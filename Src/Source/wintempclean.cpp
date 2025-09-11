#include "Src/Header/wintempclean.h"
#include "Src/logs/loghelper.h"
#include <QDebug>
#include <QtConcurrent/QtConcurrent>
#include <QElapsedTimer>

WinTempClean::WinTempClean(QObject *parent) : QObject(parent) {}

void WinTempClean::cleanWinTemp(CleanMode mode, bool isNotTap) {
    QtConcurrent::run([this, mode, isNotTap]() {
        removeWinTempFiles(mode, isNotTap);
    });
}

void WinTempClean::removeWinTempFiles(CleanMode mode, bool isNotTap) {
    QElapsedTimer timer;
    if (mode == CleanMode::DEBUG) {
        timer.start();
    }

    if (mode != CleanMode::FAST) {
        LogHelper::logMessage("winTempClean", "<<НОВАЯ СЕССИЯ ОЧИСТКИ WIN TEMP>>", true);
    }

    QString tempPath = "C:/Windows/Temp";
    QDir tempDir(tempPath);

    qint64 totalSize = 0;
    int fileCount = 0;
    bool emitCalled = false;

    for (const QFileInfo &fileInfo : tempDir.entryInfoList(QDir::Files | QDir::NoDotAndDotDot)) {
        totalSize += fileInfo.size();
        QFile::remove(fileInfo.absoluteFilePath());

        if (mode != CleanMode::FAST) {
            LogHelper::logMessage("winTempClean", "Удалён файл: " + fileInfo.fileName().toStdString() +
                                                      ", размер: " + std::to_string(fileInfo.size() / 1024.0) + " KB.");
        }

        fileCount++;
    }

    double cleanedMB = static_cast<double>(totalSize) / (1024 * 1024);

    if (totalSize > 0) {
        emitCalled = true;

        QString sizeStr = QString::number(cleanedMB, 'f', 2);

        if (isNotTap) {
            emit winTempCleaned(sizeStr);
        } else {
            emit winTempCleanedTap(sizeStr);
        }

        if (mode != CleanMode::FAST) {
            LogHelper::logMessage("winTempClean", "Очистка завершена. Освобождено данных на: "   +
                                                      std::to_string(cleanedMB) + " MB.");
        }
    }

    if (!emitCalled) {
        if (isNotTap) {
            emit winTempCleaned("0");
        } else {
            emit winTempCleanedTap("0");
        }

        if (mode != CleanMode::FAST) {
            LogHelper::logMessage("winTempClean", "Папка Win Temp пуста.");
        }
    }

    if (mode == CleanMode::DEBUG) {
        LogHelper::logMessage("winTempClean", "Время выполнения очистки: " +
                                                  std::to_string(timer.elapsed() / 1000.0) + " с.");
    }
}



void WinTempClean::calculateWinTempRemovableSize() {
    quint64 thisTaskId = ++currentTaskId;
    isCalculating.store(true);

    QtConcurrent::run([this, thisTaskId]() {
        QString tempPath = "C:/Windows/Temp";
        QDir tempDir(tempPath);
        if (!tempDir.exists()) {
            if (thisTaskId == currentTaskId) {
                emit sizeDelete("0");
                isCalculating.store(false);
            }
            return;
        }

        qint64 totalSize = 0;
        for (const QFileInfo &fileInfo : tempDir.entryInfoList(QDir::Files | QDir::Dirs | QDir::NoDotAndDotDot)) {
            if (thisTaskId != currentTaskId) {
                return;
            }

            if (fileInfo.isDir()) {
                QDir subDir(fileInfo.absoluteFilePath());
                for (const QFileInfo &subInfo : subDir.entryInfoList(QDir::Files | QDir::Dirs | QDir::NoDotAndDotDot, QDir::DirsFirst)) {
                    if (thisTaskId != currentTaskId) {
                        return;
                    }
                    if (subInfo.isFile()) {
                        totalSize += subInfo.size();
                    } else if (subInfo.isDir()) {
                        QDir subSubDir(subInfo.absoluteFilePath());
                        for (const QFileInfo &subSubInfo : subSubDir.entryInfoList(QDir::Files | QDir::NoDotAndDotDot)) {
                            if (thisTaskId != currentTaskId) {
                                return;
                            }
                            totalSize += subSubInfo.size();
                        }
                    }
                }
            } else {
                totalSize += fileInfo.size();
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
