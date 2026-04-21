#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "usbmanager.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;          // 1. Create engine FIRST

    USBManager usbManager;                 // 2. Create your object
    engine.rootContext()->setContextProperty("usbManager", &usbManager);  // 3. Expose to QML

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.loadFromModule("MultimediaPlayer", "Main");  // 4. Load QML LAST

    return app.exec();
}
