#ifndef WINUPDATECACHE_H
#define WINUPDATECACHE_H

#include <QObject>
#include <atomic>

class WinUpdateCache : public QObject {
    Q_OBJECT
public:
    explicit WinUpdateCache(QObject* parent = nullptr);

    enum WinUpdateCacheMode {
        FAST,
        NORMAL,
        DEBUG
    };
    Q_ENUM(WinUpdateCacheMode)

    Q_INVOKABLE void updateClean(WinUpdateCacheMode mode, bool isNotTap);
    Q_INVOKABLE void calculateUpdateCacheRemovableSize();

signals:
    void getterClean(QString result);
    void getterCleanTap(QString result);
    void sizeDelete(QString result);

private:
    std::atomic<bool> isCalculating = false;
    std::atomic<quint64> currentTaskId = 0;
};

#endif // WINUPDATECACHE_H
