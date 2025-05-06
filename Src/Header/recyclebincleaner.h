#ifndef RECYCLEBINCLEANER_H
#define RECYCLEBINCLEANER_H

#include <QObject>
#include <atomic>

class recycleBinCleaner : public QObject
{
    Q_OBJECT
public:
    explicit recycleBinCleaner(QObject *parent = nullptr);

    enum class RecycleBinMode {
        FAST,
        NORMAL,
        DEBUG
    };
    Q_ENUM(RecycleBinMode)

    Q_INVOKABLE void cleanRecycleBin(RecycleBinMode mode, bool isNotTap);
    Q_INVOKABLE void calculateRecycleBinRemovableSize();

signals:
    void recycleBinCleaned(QString result);
    void recycleBinCleanedTap(QString result);
    void sizeDelete(QString result);

private:
    std::atomic<bool> isCalculating = false;
    std::atomic<quint64> currentTaskId = 0;
};

#endif // RECYCLEBINCLEANER_H
