#include "Src/Header/appcontroller.h"
#include <QSettings>
#include <QCoreApplication>

AppController::AppController(QObject *parent) : QObject(parent) {}

void AppController::addToAutostart() {
    QSettings settings("HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Run", QSettings::NativeFormat);
    settings.setValue("Quanta", QCoreApplication::applicationFilePath().replace("/", "\\"));
}

void AppController::removeFromAutostart() {
    QSettings settings("HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Run", QSettings::NativeFormat);
    settings.remove("Quanta");
}
