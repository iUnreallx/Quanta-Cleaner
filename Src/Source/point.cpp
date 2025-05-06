#include "Src/Header/point.h"
#include "Src/logs/loghelper.h"
#include "Src/Header/isAdminChecked.h"
#include <QDebug>
#include <QProcess>
#include <QtConcurrent/QtConcurrent>
#include <windows.h>
#include <QElapsedTimer>

PointCleaner::PointCleaner(QObject *parent) : QObject(parent) {}

void PointCleaner::cleanRestorePoints(RestorePointMode mode,  bool isNotTap) {
    QtConcurrent::run([this, mode, isNotTap]() {
        removeRestorePoints(mode, isNotTap);
    });
}

qint64 getShadowStorageSize() {
    QProcess process;
    process.start("cmd.exe", {"/c", "vssadmin list shadowstorage /for=C:"});
    if (!process.waitForStarted() || !process.waitForFinished() || process.exitCode() != 0) {
        return 0;
    }

    QString output = QString::fromLocal8Bit(process.readAllStandardOutput());
    QStringList lines = output.split('\n', Qt::SkipEmptyParts);

    for (const QString &line : lines) {
        QString trimmed = line.trimmed();
        if (trimmed.contains("Allocated Shadow Copy Storage space:") ||
            trimmed.contains("Выделено места для хранения теневых копий:")) {

            int colon = trimmed.indexOf(':');
            if (colon == -1) continue;

            QString sizeStr = trimmed.mid(colon + 1).trimmed();
            QStringList parts = sizeStr.split(' ', Qt::SkipEmptyParts);
            if (parts.isEmpty()) continue;

            bool ok;
            double size = parts[0].replace(',', '.').toDouble(&ok);
            if (!ok) continue;

            QString unit = parts.size() > 1 ? parts[1] : "";
            if (unit == "KB" || unit == "КБ") size *= 1024;
            else if (unit == "MB" || unit == "МБ") size *= 1024 * 1024;
            else if (unit == "GB" || unit == "ГБ") size *= 1024 * 1024 * 1024;
            else continue;

            return static_cast<qint64>(size);
        }
    }

    return 0;
}


void PointCleaner::removeRestorePoints(RestorePointMode mode, bool isNotTap) {
    QElapsedTimer timer;
    if (mode == DEBUG) {
        timer.start();
    }

    if (mode != FAST) {
        LogHelper::logMessage("PointCleaner", "<<НОВАЯ СЕССИЯ ОЧИСТКИ ТОЧЕК ВОССТАНОВЛЕНИЯ>>", true);
    }

    bool isAdmin = IsAdminChecked::isRunningAsAdmin();
    LogHelper::logMessage("PointCleaner", "Права администратора: " + std::string(isAdmin ? "ДА" : "НЕТ"));

    if (!isAdmin) {
        if (mode != FAST) {
            LogHelper::logError("PointCleaner", "Процесс запущен не от имени администратора");
        }
        emit isNotTap ? restorePointsCleaned("0") : restorePointsCleanedTap("0");
        return;
    }

    qint64 freeSpaceBefore = getShadowStorageSize();
    LogHelper::logMessage("PointCleaner", "Объём теневого хранилища ДО очистки: " + std::to_string(freeSpaceBefore / (1024 * 1024)) + " MB");

    QProcess process;
    QString program = "cmd.exe";
    QStringList arguments = {"/c", "C:\\Windows\\System32\\vssadmin.exe delete shadows /for=C: /all /quiet"};

    LogHelper::logMessage("PointCleaner", "Запуск команды: " + (program + " " + arguments.join(" ")).toStdString());

    process.start(program, arguments);

    if (!process.waitForStarted()) {
        LogHelper::logError("PointCleaner", "Не удалось запустить процесс.");
        emit isNotTap ? restorePointsCleaned("0") : restorePointsCleanedTap("0");
        return;
    }

    if (!process.waitForFinished(10000)) {
        LogHelper::logError("PointCleaner", "Процесс не завершился за отведённое время. Принудительное завершение.");
        process.kill();
        emit isNotTap ? restorePointsCleaned("0") : restorePointsCleanedTap("0");
        return;
    }

    if (process.error() != QProcess::UnknownError) {
        LogHelper::logError("PointCleaner", "Ошибка процесса: " + process.errorString().toStdString());
    }

    QString stdoutData = QString::fromLocal8Bit(process.readAllStandardOutput());
    QString stderrData = QString::fromLocal8Bit(process.readAllStandardError());
    int exitCode = process.exitCode();

    LogHelper::logMessage("PointCleaner", "vssadmin stdout: " + stdoutData.toStdString());
    LogHelper::logMessage("PointCleaner", "vssadmin stderr: " + stderrData.toStdString());
    LogHelper::logMessage("PointCleaner", "Код выхода: " + std::to_string(exitCode));

    qint64 freeSpaceAfter = getShadowStorageSize();
    LogHelper::logMessage("PointCleaner", "Объём теневого хранилища ПОСЛЕ очистки: " + std::to_string(freeSpaceAfter / (1024 * 1024)) + " MB");

    if (exitCode == 0) {
        qint64 freedSpace = (freeSpaceBefore - freeSpaceAfter) / (1024 * 1024);
        if (mode != FAST) {
            LogHelper::logMessage("PointCleaner", "Очистка завершена. Освобождено: " + std::to_string(freedSpace) + " MB");
        }
        emit isNotTap ? restorePointsCleaned(QString::number(freedSpace)) : restorePointsCleanedTap(QString::number(freedSpace));
    } else {
        if (mode != FAST) {
            LogHelper::logError("PointCleaner", "Очистка завершилась с ошибкой. Возможно, точек для удаления нет.");
        }
        emit isNotTap ? restorePointsCleaned("0") : restorePointsCleanedTap("0");
    }

    if (mode == DEBUG) {
        LogHelper::logMessage("PointCleaner", "Время выполнения очистки: " + std::to_string(timer.elapsed() / 1000.0) + " с.");
    }
}





void PointCleaner::calculateRestorePointRemovableSize() {
    quint64 thisTaskId = ++currentTaskId;
    isCalculating.store(true);

    QtConcurrent::run([this, thisTaskId]() {
        if (thisTaskId != currentTaskId) {
            emit sizeDelete("0");
            isCalculating.store(false);
            return;
        }

        if (!IsAdminChecked::isRunningAsAdmin()) {
            if (thisTaskId == currentTaskId) {
                emit sizeDelete("0");
                isCalculating.store(false);
            }
            return;
        }

        QProcess process;
        process.start("cmd.exe", {"/c", "vssadmin list shadowstorage /for=C:"});
        if (!process.waitForStarted()) {
            if (thisTaskId == currentTaskId) {
                emit sizeDelete("0");
                isCalculating.store(false);
            }
            return;
        }

        process.waitForFinished();
        if (process.exitCode() != 0) {
            if (thisTaskId == currentTaskId) {
                emit sizeDelete("0");
                isCalculating.store(false);
            }
            return;
        }

        QString output = QString::fromLocal8Bit(process.readAllStandardOutput());

        qint64 totalSize = 0;
        QStringList lines = output.split('\n', Qt::SkipEmptyParts);
        for (const QString &line : lines) {
            if (thisTaskId != currentTaskId) {
                emit sizeDelete("0");
                isCalculating.store(false);
                return;
            }

            QString trimmedLine = line.trimmed();
            if (trimmedLine.contains("Allocated Shadow Copy Storage space:") ||
                trimmedLine.contains("Выделено места для хранения теневых копий:")) {

                int colonPos = trimmedLine.indexOf(':');
                if (colonPos == -1) continue;
                QString sizeStr = trimmedLine.mid(colonPos + 1).trimmed();

                QStringList parts = sizeStr.split(' ', Qt::SkipEmptyParts);
                if (parts.isEmpty()) continue;

                bool ok;
                double size = parts[0].replace(',', '.').toDouble(&ok);
                if (!ok) {
                    continue;
                }

                QString unit = parts.size() > 1 ? parts[1] : "";

                if (unit == "КБ" || unit == "KB") {
                    size *= 1024;
                } else if (unit == "МБ" || unit == "MB") {
                    size *= 1024 * 1024;
                } else if (unit == "ГБ" || unit == "GB") {
                    size *= 1024 * 1024 * 1024;
                } else {
                    continue;
                }

                totalSize += static_cast<qint64>(size);
            }
        }

        if (thisTaskId == currentTaskId) {
            double sizeInMB = static_cast<double>(totalSize) / (1024.0 * 1024.0);
            std::ostringstream oss;
            oss << std::fixed << std::setprecision(2) << sizeInMB;
            emit sizeDelete(QString::fromStdString(oss.str()));
            isCalculating.store(false);
        }
    });
}
