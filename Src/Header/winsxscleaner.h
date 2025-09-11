#ifndef WINSXSCLEANER_H
#define WINSXSCLEANER_H

#include <QObject>
#include <QString>

enum CleanupMode {
    FAST,
    NORMAL,
    DEBUG
};

class WinSxSCleaner : public QObject {
    Q_OBJECT
public:
    explicit WinSxSCleaner(QObject *parent = nullptr);

    Q_INVOKABLE void cleanWinSXS(CleanupMode mode, bool isNotTap);

signals:
    void cleanupWinSXSPoint(QString result);
    void cleanupWinSXSPointTap(QString result);
};

#endif // WINSXSCLEANER_H
