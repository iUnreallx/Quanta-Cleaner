#ifndef WINTEMPCLEAN_H
#define WINTEMPCLEAN_H

#include <QObject>
#include <QString>
#include <QDir>
#include <atomic>

class WinTempClean : public QObject {
    Q_OBJECT
public:
    explicit WinTempClean(QObject *parent = nullptr);

    enum class CleanMode {
        FAST,
        NORMAL,
        DEBUG
    };
    Q_ENUM(CleanMode)

    Q_INVOKABLE void cleanWinTemp(CleanMode mode, bool isNotTap);
    Q_INVOKABLE void calculateWinTempRemovableSize();

signals:
    void winTempCleaned(QString result);
    void winTempCleanedTap(QString result);
    void sizeDelete(QString result);

private:
    void removeWinTempFiles(CleanMode mode, bool isNotTap);
    std::atomic<bool> isCalculating = false;
    std::atomic<quint64> currentTaskId = 0;
};

#endif // WINTEMPCLEAN_H
