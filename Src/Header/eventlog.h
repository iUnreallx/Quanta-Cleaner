#ifndef EVENTLOG_H
#define EVENTLOG_H

#include <QObject>
#include <QString>
#include <QtConcurrent/QtConcurrent>
#include <windows.h>
#include <string>
#include <atomic>

class EventLog : public QObject {
    Q_OBJECT
public:
    explicit EventLog(QObject *parent = nullptr);

    enum EventLogMode {
        FAST,
        NORMAL,
        DEBUG
    };
    Q_ENUM(EventLogMode)

    Q_INVOKABLE void cleanEventLogs(EventLogMode mode, bool isNotTap);
    Q_INVOKABLE void calculateEventLogRemovableSize();

signals:
    void eventLogsCleaned(QString result);
    void eventLogsCleanedTap(QString result);
    void sizeDelete(QString result);

private:
    void removeEventLogFiles(EventLogMode mode, bool isNotTap);
    std::atomic<bool> isCalculating = false;
    std::atomic<quint64> currentTaskId = 0;
};

#endif // EVENTLOG_H
