#include "Src/Header/crashdump.h"
#include "Src/logs/loghelper.h"
#include <QDir>
#include <QStandardPaths>
#include <QDebug>
#include <QtConcurrent/QtConcurrent>
#include <QElapsedTimer>
#include <sstream>
#include <iomanip>

CrashDump::CrashDump(QObject *parent) : QObject(parent) {}

void CrashDump::cleanCrashDumps(CrashDumpMode mode, bool isNotTap) {
    QtConcurrent::run([this, mode, isNotTap]() {
        removeCrashDumpFiles(mode, isNotTap);
    });
}

void CrashDump::removeCrashDumpFiles(CrashDumpMode mode, bool isNotTap) {
    QString userName = qgetenv("USERNAME");
    QString crashDumpPath = "C:/Users/" + userName + "/AppData/Local/CrashDumps";
    QDir dumpDir(crashDumpPath);

    bool emitCalled = false;

    if (mode != CrashDumpMode::FAST) {
        LogHelper::logMessage("crashDump", "<<НОВАЯ СЕССИЯ ОЧИСТКИ CRASH DUMP>>", true);
    }

    if (!dumpDir.exists()) {
        if (mode != CrashDumpMode::FAST) {
            LogHelper::logError("crashDump", "Каталог дампов не найден!", false);
        }
        if (isNotTap) {
            emit crashDumpsCleaned(QString::number(0));
        } else {
            emit crashDumpsCleanedTap(QString::number(0));
        }
        return;
    }

    qint64 totalSize = 0;
    int fileCount = 0;
    QElapsedTimer timer;

    if (mode == CrashDumpMode::DEBUG) {
        timer.start();
    }

    for (const QFileInfo &fileInfo : dumpDir.entryInfoList({"*.dmp"}, QDir::Files)) {
        totalSize += fileInfo.size();

        if (mode == CrashDumpMode::NORMAL || mode == CrashDumpMode::DEBUG) {
            LogHelper::logMessage("crashDump", "Удален дамп: " + fileInfo.fileName().toStdString() +
                                                   ", размер: " + std::to_string(fileInfo.size() / (1024.0 * 1024.0)) + " MB.", false);
        }

        QFile::remove(fileInfo.absoluteFilePath());
        fileCount++;
    }

    double cleanedMB = static_cast<double>(totalSize) / (1024 * 1024);
    QString cleanedStr = QString::number(cleanedMB, 'f', 2);

    if (totalSize > 0) {
        if (isNotTap) {
            emit crashDumpsCleaned(cleanedStr);
        } else {
            emit crashDumpsCleanedTap(cleanedStr);
        }
        emitCalled = true;

        if (mode == CrashDumpMode::NORMAL || mode == CrashDumpMode::DEBUG) {
            LogHelper::logMessage("crashDump", "Очистка завершена. Освобождено данных на: "  + cleanedStr.toStdString() + " MB", false);
        }

        if (mode == CrashDumpMode::DEBUG) {
            qint64 elapsedMs = timer.elapsed();
            double elapsedSec = static_cast<double>(elapsedMs) / 1000.0;
            LogHelper::logMessage("crashDump", "Время выполнения очистки: " + std::to_string(elapsedSec) + " с.", false);
        }
    }

    if (!emitCalled) {
        if (isNotTap) {
            emit crashDumpsCleaned(cleanedStr);
        } else {
            emit crashDumpsCleanedTap(cleanedStr);
        }

        if (mode == CrashDumpMode::NORMAL || mode == CrashDumpMode::DEBUG) {
            LogHelper::logMessage("crashDump", "Очистка завершена. Дамп-файлы не найдены.", false);
        }

        if (mode == CrashDumpMode::DEBUG) {
            qint64 elapsedMs = timer.isValid() ? timer.elapsed() : 0;
            double elapsedSec = static_cast<double>(elapsedMs) / 1000.0;
            LogHelper::logMessage("crashDump", "Время выполнения очистки: " + std::to_string(elapsedSec) + " с.", false);
        }
    }
}

void CrashDump::calculateCrashDumpRemovableSize() {
    quint64 thisTaskId = ++currentTaskId;
    isCalculating.store(true);

    QtConcurrent::run([this, thisTaskId]() {
        if (thisTaskId != currentTaskId) {
            emit sizeDelete("0");
            isCalculating.store(false);
            return;
        }

        QString userName = qgetenv("USERNAME");
        QString crashDumpPath = "C:/Users/" + userName + "/AppData/Local/CrashDumps";
        QDir dumpDir(crashDumpPath);

        if (!dumpDir.exists()) {
            if (thisTaskId == currentTaskId) {
                emit sizeDelete("0");
                isCalculating.store(false);
            }
            return;
        }

        qint64 totalSize = 0;
        for (const QFileInfo &fileInfo : dumpDir.entryInfoList({"*.dmp"}, QDir::Files)) {
            totalSize += fileInfo.size();
        }

        if (thisTaskId == currentTaskId) {
            double sizeInMB = static_cast<double>(totalSize) / (1024.0 * 1024.0);
            std::ostringstream oss;
            oss << std::fixed << std::setprecision(2) << sizeInMB;
            emit sizeDelete(QString::fromStdString(oss.str()));
            isCalculating.store(false);
            return;
        }
    });
}
