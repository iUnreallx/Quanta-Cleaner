#ifndef POINT_H
#define POINT_H

#include <QObject>
#include <QString>
#include <QtConcurrent/QtConcurrent>
#include <QProcess>
#include <atomic>

class PointCleaner : public QObject {
    Q_OBJECT
public:
    explicit PointCleaner(QObject *parent = nullptr);

    enum RestorePointMode {
        FAST,
        NORMAL,
        DEBUG
    };
    Q_ENUM(RestorePointMode)

    Q_INVOKABLE void cleanRestorePoints(RestorePointMode mode, bool isNotTap);
    Q_INVOKABLE void calculateRestorePointRemovableSize();

signals:
    void restorePointsCleaned(QString result);
    void restorePointsCleanedTap(QString result);
    void sizeDelete(QString result);

private:
    void removeRestorePoints(RestorePointMode mode, bool isNotTap);
    std::atomic<bool> isCalculating = false;
    std::atomic<quint64> currentTaskId = 0;
};

#endif // POINT_H
