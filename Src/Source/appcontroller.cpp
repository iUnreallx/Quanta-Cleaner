#include "Src/Header/appcontroller.h"
#include <QSettings>
#include <QCoreApplication>
#include <QDebug>

AppController::AppController(QObject *parent) : QObject(parent) {
    QSettings settings("QuantaRxc", "Quanta");
    QString lang = settings.value("settings_language", "eng").toString();

    QString basePath = QCoreApplication::applicationDirPath();
    QString translationFile = (lang == "rus")
                                  ? basePath + "/localization/quanta_ru.qm"
                                  : basePath + "/localization/quanta_en.qm";

    if (m_translator.load(translationFile)) {
        QCoreApplication::installTranslator(&m_translator);
    }
}

void AppController::setLanguage(const QString &lang) {
    QSettings settings("QuantaRxc", "Quanta");
    settings.setValue("settings_language", lang);

    QString basePath = QCoreApplication::applicationDirPath();
    QString translationFile = (lang == "rus")
                                  ? basePath + "/localization/quanta_ru.qm"
                                  : basePath + "/localization/quanta_en.qm";

    QCoreApplication::removeTranslator(&m_translator);

    if (m_translator.load(translationFile)) {
        QCoreApplication::installTranslator(&m_translator);
        m_languageVersion++;
        emit languageVersionChanged();
    }
}


void AppController::addToAutostart() {
    QSettings settings("HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Run", QSettings::NativeFormat);
    settings.setValue("Quanta", QCoreApplication::applicationFilePath().replace("/", "\\"));
}

void AppController::removeFromAutostart() {
    QSettings settings("HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Run", QSettings::NativeFormat);
    settings.remove("Quanta");
}

