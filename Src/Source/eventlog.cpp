#include "Src/Header/eventlog.h"
#include "Src/logs/loghelper.h"
#include <QDir>
#include <QDebug>
#include <QtConcurrent/QtConcurrent>
#include <QElapsedTimer>

EventLog::EventLog(QObject *parent) : QObject(parent) {}

void EventLog::cleanEventLogs(EventLogMode mode, bool isNotTap) {
    QtConcurrent::run([this, mode, isNotTap]() {
        removeEventLogFiles(mode, isNotTap);
    });
}

void EventLog::removeEventLogFiles(EventLogMode mode, bool isNotTap) {
    QDir logDir("C:/Windows/System32/winevt/Logs");

    bool emitCalled = false;
    qint64 totalSize = 0;
    int fileCount = 0;
    QElapsedTimer timer;

    if (mode != EventLogMode::FAST) {
        LogHelper::logMessage("eventLog", "<<НОВАЯ СЕССИЯ ОЧИСТКИ EVENT LOG>>", true);
    }

    if (!logDir.exists()) {
        if (mode != FAST) {
            LogHelper::logError("eventLog", "Каталог логов не найден!", false);
        }
        if (isNotTap) {
            emit eventLogsCleaned("0");
        } else {
            emit eventLogsCleanedTap("0");
        }
        return;
    }

    if (mode == DEBUG) {
        timer.start();
    }

    for (const QFileInfo &fileInfo : logDir.entryInfoList({"*.evtx"}, QDir::Files)) {
        totalSize += fileInfo.size();

        if (mode == NORMAL || mode == DEBUG) {
            LogHelper::logMessage("eventLog", "Удален лог: " + fileInfo.fileName().toStdString() +
                                                  ", размер: " + std::to_string(fileInfo.size() / (1024.0 * 1024.0)) + " MB.", false);
        }

        QFile::remove(fileInfo.absoluteFilePath());
        fileCount++;
    }

    double cleanedMB = static_cast<double>(totalSize) / (1024 * 1024);
    QString cleanedStr = QString::number(cleanedMB, 'f', 2);

    if (totalSize > 0) {
        emitCalled = true;
        if (isNotTap) {
            emit eventLogsCleaned(cleanedStr);
        } else {
            emit eventLogsCleanedTap(cleanedStr);
        }

        if (mode == NORMAL || mode == DEBUG) {
            LogHelper::logMessage("eventLog", "Очистка завершена. Освобождено данных на:  " + cleanedStr.toStdString() + " MB.", false);
        }

        if (mode == DEBUG) {
            double elapsedSec = static_cast<double>(timer.elapsed()) / 1000.0;
            LogHelper::logMessage("eventLog", "Время выполнения очистки: " + std::to_string(elapsedSec) + " с.", false);
        }
    }

    if (!emitCalled) {
        if (isNotTap) {
            emit eventLogsCleaned("0");
        } else {
            emit eventLogsCleanedTap("0");
        }

        if (mode == NORMAL || mode == DEBUG) {
            LogHelper::logMessage("eventLog", "Очистка завершена. Файлы отсутствуют.", false);
        }

        if (mode == DEBUG) {
            double elapsedSec = static_cast<double>(timer.elapsed()) / 1000.0;
            LogHelper::logMessage("eventLog", "Время выполнения очистки: " + std::to_string(elapsedSec) + " с.", false);
        }
    }
}



void EventLog::calculateEventLogRemovableSize() {
    quint64 thisTaskId = ++currentTaskId;
    isCalculating.store(true);

    QtConcurrent::run([this, thisTaskId]() {
        if (thisTaskId != currentTaskId) {
            emit sizeDelete("0");
            isCalculating.store(false);
            return;
        }

        QDir logDir("C:/Windows/System32/winevt/Logs");
        if (!logDir.exists()) {
            if (thisTaskId == currentTaskId) {
                emit sizeDelete("0");
                isCalculating.store(false);
            }
            return;
        }

        qint64 totalSize = 0;
        for (const QFileInfo &fileInfo : logDir.entryInfoList({"*.evtx"}, QDir::Files)) {
            if (thisTaskId != currentTaskId) {
                emit sizeDelete("0");
                isCalculating.store(false);
                return;
            }
            totalSize += fileInfo.size();
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
