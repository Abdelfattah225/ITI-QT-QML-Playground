#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "WeatherManager.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<WeatherManager>("WeatherApp",1,0,"WeatherManager");


    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("Task04_WeatherApp", "Main");

    return app.exec();
}
