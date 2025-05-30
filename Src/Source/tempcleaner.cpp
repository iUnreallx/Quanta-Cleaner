#include "Src/Header/tempcleaner.h"
#include "Src/logs/loghelper.h"
#include <Windows.h>
#include <string>
#include <sstream>
#include <iomanip>
#include <QDebug>
#include <chrono>
#include <QtConcurrent/QtConcurrent>

TempCleaner::TempCleaner(QObject *parent) : QObject(parent) {}

ULONGLONG TempCleaner::removeDirectoryRecursively(const std::string& directoryPath, TempCleanMode mode) {
    ULONGLONG totalSize = 0;
    std::string searchPath = directoryPath + "\\*";
    WIN32_FIND_DATAA findFileData;
    HANDLE hFind = FindFirstFileA(searchPath.c_str(), &findFileData);

    if (hFind == INVALID_HANDLE_VALUE) return 0;

    do {
        std::string fileName = findFileData.cFileName;
        std::string fullPath = directoryPath + "\\" + fileName;

        if (fileName == "." || fileName == "..") continue;

        if (findFileData.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) {
            totalSize += removeDirectoryRecursively(fullPath, mode);
            if (RemoveDirectoryA(fullPath.c_str()) && mode != FAST) {
                LogHelper::logMessage("tempLog", "Удалена папка: " + fullPath);
            }
        } else {
            ULONGLONG fileSize = (static_cast<ULONGLONG>(findFileData.nFileSizeHigh) << 32) + findFileData.nFileSizeLow;
            totalSize += fileSize;

            if (DeleteFileA(fullPath.c_str())) {
                if (mode != FAST) {
                    LogHelper::logMessage("tempLog", "Удален файл: " + fullPath + " (" + std::to_string(fileSize / 1024) + " KB)");
                }
            }
        }
    } while (FindNextFileA(hFind, &findFileData) != 0);

    FindClose(hFind);
    return totalSize;
}

void TempCleaner::clearTempFolder(TempCleanMode mode, bool isNotTap) {
    QtConcurrent::run([this, mode, isNotTap]() {
        auto startTime = std::chrono::high_resolution_clock::now();

        char tempPath[MAX_PATH];
        DWORD length = GetTempPathA(MAX_PATH, tempPath);

        if (mode != TempCleanMode::FAST) {
            LogHelper::logMessage("tempLog", "<<НОВАЯ СЕССИЯ ОЧИСТКИ TEMP>>", true);
        }

        if (length == 0 || length > MAX_PATH) {
            if (mode != FAST) {
                LogHelper::logError("tempLog", "Ошибка при получении пути к временной папке.");
            }
            if (isNotTap) {
                emit tempCleanResult("0");
            } else {
                emit tempCleanResultTap("0");
            }
            return;
        }

        ULONGLONG totalDeletedSize = 0;
        WIN32_FIND_DATAA findFileData;
        HANDLE hFind;
        bool emitCalled = false;
        std::string searchPath = std::string(tempPath) + "\\*";

        hFind = FindFirstFileA(searchPath.c_str(), &findFileData);
        if (hFind == INVALID_HANDLE_VALUE) {
            if (mode != FAST) {
                LogHelper::logError("tempLog", "Ошибка доступа к временной папке: " + std::string(tempPath));
            }
            if (isNotTap) {
                emit tempCleanResult("0");
            } else {
                emit tempCleanResultTap("0");
            }
            return;
        }

        std::vector<std::string> directoriesToDelete;

        do {
            std::string fileName = findFileData.cFileName;
            std::string fullPath = std::string(tempPath) + "\\" + fileName;

            if (fileName == "." || fileName == "..") continue;

            if (findFileData.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) {
                totalDeletedSize += removeDirectoryRecursively(fullPath, mode);
                directoriesToDelete.push_back(fullPath);
            } else {
                ULONGLONG fileSize = (static_cast<ULONGLONG>(findFileData.nFileSizeHigh) << 32) + findFileData.nFileSizeLow;
                totalDeletedSize += fileSize;

                if (!DeleteFileA(fullPath.c_str())) {
                    if (mode != FAST) {
                        LogHelper::logError("tempLog", "Не смог удалить файл: " + fullPath);
                    }
                } else {
                    if (mode != FAST) {
                        LogHelper::logMessage("tempLog", "Удален файл: " + fullPath + " (" + std::to_string(fileSize / 1024) + " KB.)");
                    }
                }
            }
        } while (FindNextFileA(hFind, &findFileData) != 0);

        FindClose(hFind);

        for (const std::string& dir : directoriesToDelete) {
            if (!RemoveDirectoryA(dir.c_str())) {
                if (mode != FAST) {
                    LogHelper::logError("tempLog", "Не удалось удалить папку: " + dir);
                }
            } else {
                if (mode != FAST) {
                    LogHelper::logMessage("tempLog", "Удалена папка: " + dir);
                }
            }
        }

        double totalSizeMB = static_cast<double>(totalDeletedSize) / (1024 * 1024);
        std::ostringstream oss;
        oss << std::fixed << std::setprecision(2) << totalSizeMB;

        if (totalDeletedSize > 0) {
            emitCalled = true;
            if (isNotTap) {
                emit tempCleanResult(QString::fromStdString(oss.str()));
            } else {
                emit tempCleanResultTap(QString::fromStdString(oss.str()));
            }

            if (mode != FAST) {
                LogHelper::logMessage("tempLog", "Очистка завершена. Освобождено данных на: " + oss.str() + " МБ.");
            }

            if (mode == DEBUG) {
                auto endTime = std::chrono::high_resolution_clock::now();
                std::chrono::duration<double> elapsed = endTime - startTime;
                LogHelper::logMessage("tempLog", "Время выполнения очистки: " + std::to_string(elapsed.count()) + " секунд.");
            }
        }

        if (!emitCalled) {
            if (isNotTap) {
                emit tempCleanResult("0");
            } else {
                emit tempCleanResultTap("0");
            }

            if (mode != FAST) {
                LogHelper::logMessage("tempLog", "Очистка завершена. Файлы отсутствуют.");
            }

            if (mode == DEBUG) {
                auto endTime = std::chrono::high_resolution_clock::now();
                std::chrono::duration<double> elapsed = endTime - startTime;
                LogHelper::logMessage("tempLog", "Время выполнения очистки: " + std::to_string(elapsed.count()) + " секунд.");
            }
        }
    });
}



void TempCleaner::calculateTempRemovableSize() {
    quint64 thisTaskId = ++currentTaskId;
    isCalculating.store(true);

    QtConcurrent::run([this, thisTaskId]() {
        ULONGLONG totalSize = 0;
        char tempPath[MAX_PATH];
        DWORD length = GetTempPathA(MAX_PATH, tempPath);
        if (length == 0 || length > MAX_PATH) {
            if (thisTaskId == currentTaskId) {
                emit sizeDelete("0");
                isCalculating.store(false);
            }
            return;
        }

        std::string searchPath = std::string(tempPath) + "\\*";
        WIN32_FIND_DATAA findFileData;
        HANDLE hFind = FindFirstFileA(searchPath.c_str(), &findFileData);
        if (hFind == INVALID_HANDLE_VALUE) {
            if (thisTaskId == currentTaskId) {
                emit sizeDelete("0");
                isCalculating.store(false);
            }
            return;
        }

        std::function<ULONGLONG(const std::string&)> calculateSizeRecursively = [&](const std::string& path) -> ULONGLONG {
            ULONGLONG size = 0;
            std::string subSearchPath = path + "\\*";
            WIN32_FIND_DATAA data;
            HANDLE hSubFind = FindFirstFileA(subSearchPath.c_str(), &data);
            if (hSubFind == INVALID_HANDLE_VALUE) return 0;

            do {
                if (thisTaskId != currentTaskId) {
                    FindClose(hSubFind);
                    return 0;
                }

                std::string name = data.cFileName;
                if (name == "." || name == "..") continue;

                std::string fullPath = path + "\\" + name;

                if (data.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) {
                    size += calculateSizeRecursively(fullPath);
                } else {
                    ULONGLONG fileSize = (static_cast<ULONGLONG>(data.nFileSizeHigh) << 32) + data.nFileSizeLow;
                    size += fileSize;
                }

            } while (FindNextFileA(hSubFind, &data));
            FindClose(hSubFind);
            return size;
        };

        do {
            if (thisTaskId != currentTaskId) {
                FindClose(hFind);
                return;
            }

            std::string name = findFileData.cFileName;
            if (name == "." || name == "..") continue;

            std::string fullPath = std::string(tempPath) + "\\" + name;

            if (findFileData.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) {
                totalSize += calculateSizeRecursively(fullPath);
            } else {
                ULONGLONG fileSize = (static_cast<ULONGLONG>(findFileData.nFileSizeHigh) << 32) + findFileData.nFileSizeLow;
                totalSize += fileSize;
            }

        } while (FindNextFileA(hFind, &findFileData));
        FindClose(hFind);

        if (thisTaskId == currentTaskId) {
            double sizeInMB = static_cast<double>(totalSize) / (1024.0 * 1024.0);
            emit sizeDelete(QString::number(sizeInMB, 'f', 2));
            isCalculating.store(false);
        }
    });
}
