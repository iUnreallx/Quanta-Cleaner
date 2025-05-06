#ifndef APPCONTROLLER_H
#define APPCONTROLLER_H

#include <QObject>

class AppController : public QObject {
    Q_OBJECT
public:
    explicit AppController(QObject *parent = nullptr);

    Q_INVOKABLE void addToAutostart();
    Q_INVOKABLE void removeFromAutostart();
};

#endif // APPCONTROLLER_H
