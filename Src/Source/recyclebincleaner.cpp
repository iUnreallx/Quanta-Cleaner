#include "Src/Header/recyclebincleaner.h"
#include <windows.h>
#include <shlobj.h>
#include <QtConcurrent/QtConcurrent>
#include "Src/logs/loghelper.h"
#include <chrono>
#include <sddl.h>
#include <QDir>
#include <QDebug>
#include <QElapsedTimer>

recycleBinCleaner::recycleBinCleaner(QObject *parent) : QObject(parent) {}

QStringList getAllRecycleBinPaths() {
    HANDLE token;
    if (!OpenProcessToken(GetCurrentProcess(), TOKEN_QUERY, &token)) {
        return {};
    }

    DWORD size = 0;
    GetTokenInformation(token, TokenUser, nullptr, 0, &size);
    auto *tokenUser = (TOKEN_USER *)malloc(size);

    if (!GetTokenInformation(token, TokenUser, tokenUser, size, &size)) {
        free(tokenUser);
        CloseHandle(token);
        return {};
    }

    LPWSTR sidString;
    if (!ConvertSidToStringSidW(tokenUser->User.Sid, &sidString)) {
        free(tokenUser);
        CloseHandle(token);
        return {};
    }

    QString sid = QString::fromWCharArray(sidString);
    LocalFree(sidString);
    free(tokenUser);
    CloseHandle(token);

    QStringList recycleBinPaths;
    DWORD drives = GetLogicalDrives();
    for (char drive = 'A'; drive <= 'Z'; ++drive) {
        if (drives & (1 << (drive - 'A'))) {
            QString path = QString("%1:\\$Recycle.Bin\\%2").arg(drive).arg(sid);
            if (QDir(path).exists()) {
                recycleBinPaths.append(path);
            }
        }
    }
    return recycleBinPaths;
}

bool deleteFileSafe(const QString &filePath) {
    std::wstring wFilePath = filePath.toStdWString();
    SetFileAttributesW(wFilePath.c_str(), FILE_ATTRIBUTE_NORMAL);
    if (!DeleteFileW(wFilePath.c_str())) {
        return false;
    }
    return true;
}

void deleteFilesParallel(const QString &directoryPath) {
    QDir dir(directoryPath);
    if (!dir.exists()) return;

    QStringList files;
    QStringList folders;

    for (const QFileInfo &fileInfo : dir.entryInfoList(QDir::NoDotAndDotDot | QDir::AllEntries)) {
        if (fileInfo.isDir()) {
            folders.append(fileInfo.absoluteFilePath());
        } else {
            files.append(fileInfo.absoluteFilePath());
        }
    }

    QtConcurrent::blockingMap(files, [](const QString &filePath) {
        deleteFileSafe(filePath);
    });

    QtConcurrent::blockingMap(folders, [](const QString &folderPath) {
        QDir folder(folderPath);
        folder.removeRecursively();
    });
}

void recycleBinCleaner::cleanRecycleBin(RecycleBinMode mode, bool isNotTap) {
    QtConcurrent::run([this, mode, isNotTap]() {
        using namespace std::chrono;
        QElapsedTimer timer;
        bool emitCalled = false;

        qint64 size = 0;
        SHQUERYRBINFO recycleInfo;
        recycleInfo.cbSize = sizeof(SHQUERYRBINFO);

        if (SHQueryRecycleBinW(nullptr, &recycleInfo) == S_OK) {
            size = recycleInfo.i64Size;
        }

        if (mode == RecycleBinMode::DEBUG) {
            timer.start();
        }

        QStringList recycleBinPaths = getAllRecycleBinPaths();
        for (const QString &path : recycleBinPaths) {
            deleteFilesParallel(path);
        }

        if (mode != RecycleBinMode::FAST) {
            LogHelper::logMessage("recycleLog", "<<НОВАЯ СЕССИЯ ОЧИСТКИ КОРЗИНЫ (BIN)>>", true);
        }

        ULONGLONG sizeCount = size / (1024 * 1024);
        QString result = QString::number(sizeCount);

        if (size > 0) {
            emitCalled = true;
            if (isNotTap) {
                emit recycleBinCleaned(result);
            } else {
                emit recycleBinCleanedTap(result);
            }

            if (mode != RecycleBinMode::FAST) {
                LogHelper::logMessage("recycleLog", "Освобождено данных на: " + result.toStdString() + " МБ.");
            }

            if (mode == RecycleBinMode::DEBUG) {
                qint64 elapsedMs = timer.elapsed();
                double elapsedSec = static_cast<double>(elapsedMs) / 1000.0;
                 LogHelper::logMessage("recycleLog", "Время выполнения очистки: " + std::to_string(elapsedSec) + " с.", false);
            }
        }

        if (!emitCalled) {
            if (isNotTap) {
                emit recycleBinCleaned("0");
            } else {
                emit recycleBinCleanedTap("0");
            }

            if (mode != RecycleBinMode::FAST) {
                LogHelper::logMessage("recycleLog", "Корзина пуста.");
            }

            if (mode == RecycleBinMode::DEBUG) {
                qint64 elapsedMs = timer.elapsed();
                double elapsedSec = static_cast<double>(elapsedMs) / 1000.0;
                LogHelper::logMessage("recycleLog", "Время выполнения очистки: " + std::to_string(elapsedSec) + " с.", false);
            }
        }


    });
}



void recycleBinCleaner::calculateRecycleBinRemovableSize() {
    quint64 thisTaskId = ++currentTaskId;
    isCalculating.store(true);

    QtConcurrent::run([this, thisTaskId]() {
        if (thisTaskId != currentTaskId) {
            emit sizeDelete("0");
            isCalculating.store(false);
            return;
        }

        qint64 totalSize = 0;
        SHQUERYRBINFO recycleInfo;
        recycleInfo.cbSize = sizeof(SHQUERYRBINFO);

        if (SHQueryRecycleBinW(nullptr, &recycleInfo) != S_OK) {
            emit sizeDelete("0");
            isCalculating.store(false);
            return;
        }

        totalSize = recycleInfo.i64Size;

        if (thisTaskId == currentTaskId) {
            double sizeInMB = static_cast<double>(totalSize) / (1024.0 * 1024.0);
            std::ostringstream oss;
            oss << std::fixed << std::setprecision(2) << sizeInMB;
            emit sizeDelete(QString::fromStdString(oss.str()));
            isCalculating.store(false);
        } else {
            emit sizeDelete("0");
            isCalculating.store(false);
        }
    });
}
