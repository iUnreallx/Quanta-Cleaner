#ifndef FONTCACHE_H
#define FONTCACHE_H

#include <QObject>
#include <atomic>

class FontCache : public QObject {
    Q_OBJECT
public:
    explicit FontCache(QObject* parent = nullptr);

    enum FontCacheMode {
        FAST,
        NORMAL,
        DEBUG
    };
    Q_ENUM(FontCacheMode)

    Q_INVOKABLE void fontCacheClean(FontCacheMode mode, bool isNotTap);
    Q_INVOKABLE void calculateFontCacheRemovableSize();

signals:
    void fontCacheCleaned(QString result);
    void fontCacheCleanedTap(QString result);
    void sizeDelete(QString result);

private:
    std::atomic<bool> isCalculating = false;
    std::atomic<quint64> currentTaskId = 0;
};

#endif // FONTCACHE_H
