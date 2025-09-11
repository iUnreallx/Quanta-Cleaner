#ifndef APPCONTROLLER_H
#define APPCONTROLLER_H

#include <QObject>
#include <QTranslator>

class AppController : public QObject {
    Q_OBJECT
    Q_PROPERTY(int languageVersion READ languageVersion NOTIFY languageVersionChanged)

public:
    explicit AppController(QObject *parent = nullptr);
    int languageVersion() const { return m_languageVersion; }

    Q_INVOKABLE void addToAutostart();
    Q_INVOKABLE void removeFromAutostart();
    Q_INVOKABLE void setLanguage(const QString &lang);

signals:
    void languageChanged();
    void languageVersionChanged();

private:
    QTranslator m_translator;
    int m_languageVersion = 0;
};

#endif // APPCONTROLLER_H
