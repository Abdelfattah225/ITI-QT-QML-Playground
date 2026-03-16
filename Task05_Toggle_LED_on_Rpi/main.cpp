#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "LedController.h"
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<LedController>("LedControllerApp",1,0,"LedController");
    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("Task05_Toggle_LED_on_Rpi", "Main");

    return app.exec();
}
