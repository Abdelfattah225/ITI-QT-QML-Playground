#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>             // ← NEW: needed for setContextProperty
#include <QQuickStyle>
#include "wifimanager.hpp"          // ← NEW: include our class
#include "bluetoothmanager.h"
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("Material");

    // Create our WiFi manager (talks to D-Bus)
    WifiManager wifiManager;
    //Create BluetoothManager object
    BluezManager bluetoothManager;

    QQmlApplicationEngine engine;

    // Make it available in QML with the name "wifiManager"
    engine.rootContext()->setContextProperty("wifiManager", &wifiManager);
    //                                      ^^^   ^^^
    //                            QML name (string), pointer to object

    // Make it available in QML with the name "wifiManager"
    engine.rootContext()->setContextProperty("bluetoothManager", &bluetoothManager);
    //                                      ^^^   ^^^
    //                            QML name (string), pointer to object

    engine.loadFromModule("ConnectivityControl", "Main");

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
