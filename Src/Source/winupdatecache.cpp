#include "Src/Header/winupdatecache.h"
#include "Src/logs/loghelper.h"
#include <QDir>
#include <QFileInfo>
#include <QProcess>
#include <QtConcurrent/QtConcurrent>
#include <QElapsedTimer>
#include <windows.h>
#include <sstream>
#include <iomanip>
#include <QDebug>
WinUpdateCache::WinUpdateCache(QObject* parent) : QObject(parent) {}

qint64 getDirectorySize(const QString &path) {
    qint64 totalSize = 0;
    QDir dir(path);

    QFileInfoList fileList = dir.entryInfoList(QDir::Files | QDir::Hidden | QDir::System | QDir::NoDotAndDotDot);
    for (const QFileInfo &file : fileList) {
        totalSize += file.size();
    }

    QFileInfoList dirList = dir.entryInfoList(QDir::Dirs | QDir::Hidden | QDir::System | QDir::NoDotAndDotDot);
    for (const QFileInfo &subDir : dirList) {
        totalSize += getDirectorySize(subDir.filePath());
    }

    return totalSize;
}

void WinUpdateCache::updateClean(WinUpdateCacheMode mode, bool isNotTap) {
    QtConcurrent::run([this, mode, isNotTap]() {
        QElapsedTimer timer;
        if (mode == DEBUG) {
            timer.start();
        }

        if (mode != FAST) {
            LogHelper::logMessage("updateWinLog", "<<НОВАЯ СЕССИЯ ОЧИСТКИ КЕША ОБНОВЛЕНИЙ>>", true);
        }

        const QString updatePath = QDir::cleanPath("C:/Windows/SoftwareDistribution/Download");

        auto runSilentCommand = [mode](const QString &cmd, const QStringList &args) -> bool {
            QProcess process;
            process.setProgram(cmd);
            process.setArguments(args);

            QString fullCommand = cmd + " " + args.join(' ');
            if (mode != FAST) {
                LogHelper::logMessage("updateWinLog", "Выполнение команды: " + fullCommand.toStdString());
            }

            process.start();
            if (!process.waitForStarted(2500)) {
                if (mode != FAST) {
                    LogHelper::logError("updateWinLog", "Не удалось запустить команду: " + fullCommand.toStdString());
                }
                return false;
            }

            if (!process.waitForFinished(2500)) {
                if (mode != FAST) {
                    LogHelper::logError("updateWinLog", "Команда не завершилась за отведённое время: " + fullCommand.toStdString());
                }
                return false;
            }

            int exitCode = process.exitCode();
            QString stdOutput = QString::fromLocal8Bit(process.readAllStandardOutput()).trimmed();
            QString stdError = QString::fromLocal8Bit(process.readAllStandardError()).trimmed();

            if (exitCode != 0) {
                if (cmd == "net" && args.contains("stop") && args.contains("wuauserv") && exitCode == 2) {
                    if (mode != FAST) {
                        LogHelper::logMessage("updateWinLog", "Служба 'wuauserv' уже остановлена (exitCode=2). Продолжаем выполнение.");
                    }
                    return true;
                }

                if (mode != FAST) {
                    LogHelper::logError("updateWinLog", "Команда завершилась с ошибкой. Код: " + std::to_string(exitCode));
                    if (!stdOutput.isEmpty())
                        LogHelper::logError("updateWinLog", "STDOUT: " + stdOutput.toStdString());
                    if (!stdError.isEmpty())
                        LogHelper::logError("updateWinLog", "STDERR: " + stdError.toStdString());
                }
                return false;
            }

            if (mode != FAST) {
                LogHelper::logMessage("updateWinLog", "Команда выполнена успешно.");
                if (!stdOutput.isEmpty())
                    LogHelper::logMessage("updateWinLog", "STDOUT: " + stdOutput.toStdString());
            }

            return true;
        };


        if (!runSilentCommand("sc", {"config", "wuauserv", "start=", "disabled"})) {
            if (isNotTap) {
                emit getterClean("0");
            } else {
                emit getterCleanTap("0");
            }
            return;
        }
        if (!runSilentCommand("net", {"stop", "wuauserv"})) {
            if (isNotTap) {
                emit getterClean("0");
            } else {
                emit getterCleanTap("0");
            }
            return;
        }

        if (!runSilentCommand("icacls", {updatePath, "/grant", "Администраторы:F", "/T", "/C", "/Q"})) {
            if (isNotTap) {
                emit getterClean("0");
            } else {
                emit getterCleanTap("0");
            }
            return;
        }

        if (QDir(updatePath).exists()) {
            QProcess::execute("cmd.exe", {"/c", "rmdir", "/s", "/q", updatePath});
            QDir().mkpath(updatePath);
        }

        if (!runSilentCommand("sc", {"config", "wuauserv", "start=", "demand"})) {
            if (mode != FAST) {
                LogHelper::logError("updateWinLog", "Не удалось восстановить службу обновлений.");
            }
            if (isNotTap) {
                emit getterClean("0");
            } else {
                emit getterCleanTap("0");
            }
            return;
        }
        if (!runSilentCommand("net", {"start", "wuauserv"})) {
            if (mode != FAST) {
                LogHelper::logError("updateWinLog", "Не удалось запустить службу обновлений.");
            }
            if (isNotTap) {
                emit getterClean("0");
            } else {
                emit getterCleanTap("0");
            }
            return;
        }

        qint64 asyncSize = 0;
        if (mode != FAST) {
            asyncSize = getDirectorySize(updatePath);
            if (asyncSize < 0) {
                LogHelper::logError("updateWinLog", "Ошибка расчета размера папки обновлений.");
                asyncSize = 0;
            }
        }
        double asyncSizeMB = asyncSize / (1024.0 * 1024.0);

        if (asyncSize > 0) {
            QString sizeStr = QString::number(asyncSizeMB, 'f', 2);
            if (isNotTap) {
                emit getterClean(sizeStr);
            } else {
                emit getterCleanTap(sizeStr);
            }
            if (mode != FAST) {
                LogHelper::logMessage("updateWinLog", "Очистка завершена. Освобождено данных на: " + sizeStr.toStdString() + " MB.");
            }
        } else {
            if (isNotTap) {
                emit getterClean("0");
            } else {
                emit getterCleanTap("0");
            }
            if (mode != FAST) {
                LogHelper::logMessage("updateWinLog", "Кеш обновлений пуст.");
            }
        }

        if (mode == DEBUG) {
            LogHelper::logMessage("updateWinLog", "Время выполнения очистки: " + std::to_string(timer.elapsed() / 1000.0) + " с.");
        }
    });
}

void WinUpdateCache::calculateUpdateCacheRemovableSize() {
    quint64 thisTaskId = ++currentTaskId;
    isCalculating.store(true);

    QtConcurrent::run([this, thisTaskId]() {
        if (thisTaskId != currentTaskId) {
            emit sizeDelete("0");
            isCalculating.store(false);
            return;
        }

        const QString updatePath = QDir::cleanPath("C:/Windows/SoftwareDistribution/Download");
        QDir updateDir(updatePath);


        qint64 totalSize = 0;
        if (updateDir.exists()) {
            totalSize = getDirectorySize(updatePath);
        }

        if (thisTaskId != currentTaskId) {
            emit sizeDelete("0");
            isCalculating.store(false);
            return;
        }

        double sizeInMB = static_cast<double>(totalSize) / (1024.0 * 1024.0);
        std::ostringstream oss;
        oss << std::fixed << std::setprecision(2) << sizeInMB;
        if (thisTaskId == currentTaskId) {
            emit sizeDelete(QString::fromStdString(oss.str()));
            isCalculating.store(false);
        }
    });
}
