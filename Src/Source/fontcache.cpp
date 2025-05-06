#include "Src/Header/fontcache.h"
#include <QProcess>
#include <QDir>
#include <QDebug>
#include <QtConcurrent/QtConcurrent>
#include <QElapsedTimer>
#include "Src/logs/loghelper.h"

FontCache::FontCache(QObject* parent) : QObject(parent) {}

void FontCache::fontCacheClean(FontCacheMode mode, bool isNotTap) {
    QtConcurrent::run([this, mode, isNotTap]() {
        QElapsedTimer timer;
        if (mode == DEBUG) {
            timer.start();
        }

        if (mode != FAST) {
            LogHelper::logMessage("fontCache", "<<НОВАЯ СЕССИЯ ОЧИСТКИ FONT CACHE>>", true);
        }

        QString cacheFolder = "C:\\Windows\\ServiceProfiles\\LocalService\\AppData\\Local\\FontCache";
        QDir dir(cacheFolder);

        bool emitCalled = false;

        QProcess::execute("net stop FontCache");
        QProcess::execute("net stop FontCache3.0.0.0");

        qint64 totalSize = 0;
        QFileInfoList files = dir.entryInfoList(QDir::Files | QDir::NoDotAndDotDot);
        for (const QFileInfo &file : files) {
            totalSize += file.size();
            if (mode == DEBUG) {
                LogHelper::logMessage("fontCache", "Удалён файл: " + file.fileName().toStdString() +
                                                       ", размер: " + std::to_string(file.size() / 1024.0) + " KB.");
            }
        }

        QString command = "cmd";
        QStringList arguments;
        arguments << "/c" << "del /q /s \"" + cacheFolder + "\\*.*\"";

        QProcess process;
        process.start(command, arguments);
        process.waitForFinished();

        QProcess::execute("net start FontCache");
        QProcess::execute("net start FontCache3.0.0.0");

        double totalMB = static_cast<double>(totalSize) / (1024 * 1024);

        if (totalSize > 0) {
            emitCalled = true;
            QString sizeStr = QString::number(totalMB, 'f', 2);

            if (isNotTap) {
                emit fontCacheCleaned(sizeStr);
            } else {
                emit fontCacheCleanedTap(sizeStr);
            }

            if (mode != FAST) {
                LogHelper::logMessage("fontCache", "Очистка завершена. Освобождено данных на: " + sizeStr.toStdString() + " MB.");
            }
        }

        if (!emitCalled) {
            if (isNotTap) {
                emit fontCacheCleaned("0");
            } else {
                emit fontCacheCleanedTap("0");
            }

            if (mode != FAST) {
                LogHelper::logMessage("fontCache", "Кеш шрифтов пуст.");
            }
        }

        if (mode == DEBUG) {
            LogHelper::logMessage("fontCache", "Время выполнения очистки: " + std::to_string(timer.elapsed() / 1000.0) + " с.");
        }
    });
}



void FontCache::calculateFontCacheRemovableSize() {
    quint64 thisTaskId = ++currentTaskId;
    isCalculating.store(true);

    QtConcurrent::run([this, thisTaskId]() {
        QString cacheFolder = "C:\\Windows\\ServiceProfiles\\LocalService\\AppData\\Local\\FontCache";
        QDir dir(cacheFolder);
        if (!dir.exists()) {
            if (thisTaskId == currentTaskId) {
                emit sizeDelete("0");
                isCalculating.store(false);
            }
            return;
        }

        qint64 totalSize = 0;
        QFileInfoList entries = dir.entryInfoList(QDir::Files | QDir::Dirs | QDir::NoDotAndDotDot);
        for (const QFileInfo &entry : entries) {
            if (thisTaskId != currentTaskId) {
                return;
            }

            if (entry.isDir()) {
                QDir subDir(entry.absoluteFilePath());
                QFileInfoList subEntries = subDir.entryInfoList(QDir::Files | QDir::NoDotAndDotDot);
                for (const QFileInfo &subEntry : subEntries) {
                    if (thisTaskId != currentTaskId) {
                        return;
                    }
                    totalSize += subEntry.size();
                }
            } else {
                totalSize += entry.size();
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
