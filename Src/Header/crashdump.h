#ifndef CRASHDUMP_H
#define CRASHDUMP_H

#include <QObject>
#include <QString>
#include <QtConcurrent/QtConcurrent>
#include <windows.h>
#include <string>
#include <atomic>

class CrashDump : public QObject {
    Q_OBJECT
public:
    explicit CrashDump(QObject *parent = nullptr);

    enum CrashDumpMode {
        FAST,
        NORMAL,
        DEBUG
    };
    Q_ENUM(CrashDumpMode)

    Q_INVOKABLE void cleanCrashDumps(CrashDumpMode mode, bool isNotTap);
    Q_INVOKABLE void calculateCrashDumpRemovableSize();

signals:
    void crashDumpsCleaned(QString result);
    void crashDumpsCleanedTap(QString result);
    void sizeDelete(QString result);

private:
    void removeCrashDumpFiles(CrashDumpMode mode, bool isNotTap);
    std::atomic<bool> isCalculating = false;
    std::atomic<quint64> currentTaskId = 0;
};

#endif // CRASHDUMP_H
