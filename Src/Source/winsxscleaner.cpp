#include "Src/Header/winsxscleaner.h"
#include "Src/logs/loghelper.h"
#include <QtConcurrent/QtConcurrent>
#include <windows.h>
#include "Src/Header/isAdminChecked.h"
#include <QElapsedTimer>

WinSxSCleaner::WinSxSCleaner(QObject *parent) : QObject(parent) {}

void WinSxSCleaner::cleanWinSXS(CleanupMode mode, bool isNotTap) {
    QtConcurrent::run([this, mode, isNotTap]() {
        QElapsedTimer timer;
        if (mode == DEBUG) timer.start();

        if (mode != FAST) {
            LogHelper::logMessage("WinSxSCleaner", "<<НОВАЯ СЕССИЯ ОЧИСТКИ WISXS>>", true);
        }

        if (!IsAdminChecked::isRunningAsAdmin()) {
            if (mode != FAST) {
                LogHelper::logError("WinSxSCleaner", "Запуск не от имени администратора");
            }
            if (isNotTap) {
                emit cleanupWinSXSPoint("notAdmin");
            } else {
                emit cleanupWinSXSPointTap("0");
            }
            return;
        }

        char sysDir[MAX_PATH];
        if (!GetSystemDirectoryA(sysDir, MAX_PATH)) {
            if (mode != FAST) {
                LogHelper::logError("WinSxSCleaner", "Не удалось получить системный каталог. Код ошибки: " + std::to_string(GetLastError()));
            }
            if (isNotTap) {
                emit cleanupWinSXSPoint("0");
            } else {
                emit cleanupWinSXSPointTap("0");
            }
            return;
        }
        std::string drive = std::string(sysDir, 3);

        ULARGE_INTEGER beforeSpace;
        if (!GetDiskFreeSpaceExA(drive.c_str(), &beforeSpace, nullptr, nullptr)) {
            if (mode != FAST) {
                LogHelper::logError("WinSxSCleaner", "Ошибка чтения свободного места до очистки.");
            }
            if (isNotTap) {
                emit cleanupWinSXSPoint("0");
            } else {
                emit cleanupWinSXSPointTap("0");
            }
            return;
        }

        STARTUPINFOA si = { sizeof(si) };
        si.dwFlags = STARTF_USESHOWWINDOW;
        si.wShowWindow = SW_HIDE;
        PROCESS_INFORMATION pi = {0};

        std::string command = "Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase";

        BOOL success = CreateProcessA(nullptr,
                                      const_cast<char*>(command.c_str()),
                                      nullptr, nullptr, FALSE,
                                      CREATE_NO_WINDOW,
                                      nullptr, nullptr,
                                      &si, &pi);

        if (!success) {
            DWORD err = GetLastError();
            if (mode != FAST) {
                LogHelper::logError("WinSxSCleaner", "Не удалось запустить DISM (WinSxS). Код ошибки: " + std::to_string(err));
            }
            if (isNotTap) {
                emit cleanupWinSXSPoint("0");
            } else {
                emit cleanupWinSXSPointTap("0");
            }
            return;
        }

        DWORD waitResult = WaitForSingleObject(pi.hProcess, 10 * 1000); //10 sec
        if (waitResult == WAIT_TIMEOUT) {
            if (mode != FAST) {
                LogHelper::logError("WinSxSCleaner", "Очистка WinSxS заняла слишком много времени и была прервана.");
            }
            CloseHandle(pi.hProcess);
            CloseHandle(pi.hThread);
            if (isNotTap) {
                emit cleanupWinSXSPoint("0");
            } else {
                emit cleanupWinSXSPointTap("0");
            }
            return;
        } else if (waitResult != WAIT_OBJECT_0) {
            if (mode != FAST) {
                LogHelper::logError("WinSxSCleaner", "Ошибка ожидания завершения DISM.exe. Код ошибки: " + std::to_string(GetLastError()));
            }
            CloseHandle(pi.hProcess);
            CloseHandle(pi.hThread);
            if (isNotTap) {
                emit cleanupWinSXSPoint("0");
            } else {
                emit cleanupWinSXSPointTap("0");
            }
            return;
        }

        DWORD exitCode;
        if (!GetExitCodeProcess(pi.hProcess, &exitCode)) {
            if (mode != FAST) {
                LogHelper::logError("WinSxSCleaner", "Не удалось получить код завершения DISM.exe. Код ошибки: " + std::to_string(GetLastError()));
            }
            CloseHandle(pi.hProcess);
            CloseHandle(pi.hThread);
            if (isNotTap) {
                emit cleanupWinSXSPoint("0");
            } else {
                emit cleanupWinSXSPointTap("0");
            }
            return;
        }

        if (exitCode != 0) {
            if (mode != FAST) {
                LogHelper::logError("WinSxSCleaner", "DISM.exe завершился с ошибкой. Код выхода: " + std::to_string(exitCode));
            }
            CloseHandle(pi.hProcess);
            CloseHandle(pi.hThread);
            if (isNotTap) {
                emit cleanupWinSXSPoint("0");
            } else {
                emit cleanupWinSXSPointTap("0");
            }
            return;
        }

        CloseHandle(pi.hProcess);
        CloseHandle(pi.hThread);

        ULARGE_INTEGER afterSpace;
        if (!GetDiskFreeSpaceExA(drive.c_str(), &afterSpace, nullptr, nullptr)) {
            if (mode != FAST) {
                LogHelper::logError("WinSxSCleaner", "Ошибка чтения свободного места после очистки.");
            }
            if (isNotTap) {
                emit cleanupWinSXSPoint("0");
            } else {
                emit cleanupWinSXSPointTap("0");
            }
            return;
        }

        ULONGLONG freed = (afterSpace.QuadPart > beforeSpace.QuadPart)
                              ? (afterSpace.QuadPart - beforeSpace.QuadPart) : 0;
        qint64 freedMB = static_cast<qint64>(freed / (1024 * 1024));

        if (mode != FAST) {
            LogHelper::logMessage("WinSxSCleaner", "Очистка завершена. Освобождено данных на: " + std::to_string(freedMB) + " MB.");
        }

        if (mode == DEBUG) {
            LogHelper::logMessage("WinSxSCleaner", "Время выполнения очистки: " + std::to_string(timer.elapsed() / 1000.0) + " с.");
        }

        if (isNotTap) {
            emit cleanupWinSXSPoint(QString::number(freedMB));
        } else {
            emit cleanupWinSXSPointTap(QString::number(freedMB));
        }
    });
}
