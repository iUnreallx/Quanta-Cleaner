//main.cpp
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QTranslator>
#include <QLocale>
#include "Src/Header/winsxscleaner.h"
#include "Src/Header/tempcleaner.h"
#include "Src/Header/wintempclean.h"
#include "Src/Header/LogsViewer.h"
#include "Src/Header/fontcache.h"
#include "Src/Header/winupdatecache.h"
#include "Src/Header/recyclebincleaner.h"
#include "Src/Header/eventlog.h"
#include "Src/Header/crashdump.h"
#include "Src/Header/point.h"
#include "Src/Header/appcontroller.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    // QTranslator translator;
    // const QString locale = QLocale::system().name();
    // if (translator.load("rxc_beta_en_US.ts")) {
    //     app.installTranslator(&translator);
    // }

    QQmlApplicationEngine engine;
    // engine.rootContext()->setContextProperty("appTranslator", &translator);

    QCoreApplication::setOrganizationName("QuantaRxc");
    QCoreApplication::setOrganizationDomain("Quanta.com");
    QCoreApplication::setApplicationName("Quanta");

    AppController appController;
    engine.rootContext()->setContextProperty("app", &appController);

    WinTempClean wintemp;
    engine.rootContext()->setContextProperty("wintemp", &wintemp);

    WinSxSCleaner winsxs;
    engine.rootContext()->setContextProperty("winsxs", &winsxs);

    LogsViewer logsviewer;
    engine.rootContext()->setContextProperty("logsviewer", &logsviewer);

    FontCache font;
    engine.rootContext()->setContextProperty("fontQ", &font);

    TempCleaner tmp;
    engine.rootContext()->setContextProperty("tmp", &tmp);

    recycleBinCleaner binclear;
    engine.rootContext()->setContextProperty("binclear", &binclear);

    WinUpdateCache update;
    engine.rootContext()->setContextProperty("updateQ", &update);

    EventLog event;
    engine.rootContext()->setContextProperty("eventQ", &event);

    CrashDump dmp;
    engine.rootContext()->setContextProperty("dmp", &dmp);

    PointCleaner point;
    engine.rootContext()->setContextProperty("pointQ", &point);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.loadFromModule("QuantaCleaner", "Main");

    return app.exec();
}
