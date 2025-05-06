#ifndef TEMPCLEANER_H
#define TEMPCLEANER_H

#include <QObject>
#include <string>
#include <windows.h>
#include <atomic>

class TempCleaner : public QObject {
    Q_OBJECT
public:
    explicit TempCleaner(QObject *parent = nullptr);

    enum TempCleanMode {
        FAST,
        NORMAL,
        DEBUG
    };
    Q_ENUM(TempCleanMode)

    Q_INVOKABLE void calculateTempRemovableSize();
    Q_INVOKABLE void clearTempFolder(TempCleanMode mode, bool isNotTap);

signals:
    void sizeDelete(QString result);
    void tempCleanResult(QString result);
    void tempCleanResultTap(QString result);

private:
    ULONGLONG removeDirectoryRecursively(const std::string& directoryPath, TempCleanMode mode);

    std::atomic<bool> isCalculating = false;
    std::atomic<quint64> currentTaskId = 0;
};

#endif // TEMPCLEANER_H
