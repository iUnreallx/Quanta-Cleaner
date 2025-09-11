#ifndef LOGSVIEWER_H
#define LOGSVIEWER_H

#include <QObject>
#include <QString>
#include <QStringList>

class LogsViewer : public QObject {
    Q_OBJECT
    Q_PROPERTY(QStringList logs READ logs NOTIFY logsChanged)

public:
    explicit LogsViewer(QObject *parent = nullptr);
    Q_INVOKABLE void clearLogs();
    Q_INVOKABLE void loadLogs(const QString &path);
    Q_INVOKABLE void cleanLogPath(const QString &LogPath);

    QStringList logs() const {
        return m_logs;
    }

signals:
    void logsChanged();

private:
    QStringList m_logs;
};

#endif // LOGSVIEWER_H
