#include "bluetoothmanager.h"
#include <QDBusConnection>
#include <QDBusMetaType>

typedef QMap<QDBusObjectPath, QMap<QString, QVariantMap>> ManagedObjectsMap;

// ============================================================
// CONSTRUCTOR (updated)
// ============================================================
BluezManager::BluezManager(QObject *parent)
    : QObject(parent), m_scanning(false)
{
    qDBusRegisterMetaType<ManagedObjectsMap>();

    m_properties = new QDBusInterface(
        "org.bluez",
        "/org/bluez/hci0",
        "org.freedesktop.DBus.Properties",
        QDBusConnection::systemBus(), this
        );

    m_bluezPowered = readBluezState();
    qDebug() << "Initial Bluetooth State:" << m_bluezPowered;

    // Check if any device is already connected
    updateConnectedDevice();  // ← NEW
}

// ============================================================
// EXISTING FUNCTIONS (unchanged)
// ============================================================
bool BluezManager::readBluezState(){
    QDBusReply<QVariant> reply = m_properties->call("Get", "org.bluez.Adapter1", "Powered");
    if(reply.isValid()) return reply.value().toBool();
    qDebug() << "Failed to get Bluetooth state:" << reply.error().message();
    return false;
}

bool BluezManager::bluezPowered() const { return m_bluezPowered; }

void BluezManager::setBluezPowered(bool enabled){
    if(m_bluezPowered == enabled) return;
    QDBusMessage reply = m_properties->call(
        "Set", "org.bluez.Adapter1", "Powered",
        QVariant::fromValue(QDBusVariant(enabled))
        );
    if (reply.type() == QDBusMessage::ErrorMessage) {
        qWarning() << "D-Bus Error:" << reply.errorName() << reply.errorMessage();
        return;
    }
    m_bluezPowered = enabled;
    emit bluezPoweredChanged();
    qDebug() << "Bluetooth set to:" << m_bluezPowered;
}

QVariantList BluezManager::devices() const { return m_devices; }
bool BluezManager::scanning() const { return m_scanning; }
QString BluezManager::connectedDevice() const { return m_connectedDevice; }  // ← NEW


// ============================================================
// scanDevices() (updated — also refreshes connected device)
// ============================================================
void BluezManager::scanDevices()
{
    m_scanning = true;
    emit scanningChanged();

    QDBusInterface adapter(
        "org.bluez",
        "/org/bluez/hci0",
        "org.bluez.Adapter1",
        QDBusConnection::systemBus()
        );

    adapter.call("StartDiscovery");
    qDebug() << "Bluetooth discovery started...";

    QTimer::singleShot(5000, this, [this]() {
        loadDevices();

        QDBusInterface adapter(
            "org.bluez",
            "/org/bluez/hci0",
            "org.bluez.Adapter1",
            QDBusConnection::systemBus()
            );
        adapter.call("StopDiscovery");
        qDebug() << "Bluetooth discovery stopped.";

        updateConnectedDevice();  // ← NEW: refresh connected status

        m_scanning = false;
        emit scanningChanged();
    });
}


// ============================================================
// loadDevices() (updated — also stores device path!)
// ============================================================
void BluezManager::loadDevices()
{
    m_devices.clear();

    QDBusInterface objectManager(
        "org.bluez",
        "/",
        "org.freedesktop.DBus.ObjectManager",
        QDBusConnection::systemBus()
        );

    QDBusReply<ManagedObjectsMap> reply = objectManager.call("GetManagedObjects");

    if (!reply.isValid()) {
        qWarning() << "Failed to get managed objects:" << reply.error().message();
        emit devicesChanged();
        return;
    }

    ManagedObjectsMap objects = reply.value();

    for (auto it = objects.constBegin(); it != objects.constEnd(); ++it) {
        QMap<QString, QVariantMap> interfaces = it.value();

        if (!interfaces.contains("org.bluez.Device1")) {
            continue;
        }

        QVariantMap props = interfaces["org.bluez.Device1"];

        QString name = props.value("Name", "").toString();
        QString address = props["Address"].toString();
        bool paired = props["Paired"].toBool();
        bool connected = props.value("Connected", false).toBool();  // ← NEW
        int rssi = props.value("RSSI", 0).toInt();

        if (name.isEmpty()) continue;

        QVariantMap device;
        device["name"] = name;
        device["address"] = address;
        device["paired"] = paired;
        device["connected"] = connected;          // ← NEW
        device["rssi"] = rssi;
        device["path"] = it.key().path();         // ← NEW: store the D-Bus path!

        m_devices.append(device);
    }

    emit devicesChanged();
    qDebug() << "Found" << m_devices.size() << "Bluetooth devices";
}


// ============================================================
// NEW: connectToDevice()
// ============================================================
//
// Flow:
//   If NOT paired → Pair first, then Connect
//   If already paired → just Connect
//
// Compare with WiFi:
//   WiFi:      AddAndActivateConnection(settings, device, ap)
//   Bluetooth: Pair() + Connect()  (simpler!)
//

void BluezManager::connectToDevice(const QString &devicePath,
                                   const QString &name,
                                   bool paired)
{
    qDebug() << "Connecting to Bluetooth device:" << name << "at" << devicePath;

    // Create interface to the specific device
    //
    // Each Bluetooth device has its own D-Bus object:
    //   Path: "/org/bluez/hci0/dev_AA_BB_CC_DD_EE_FF"
    //   Interface: "org.bluez.Device1"
    //   Methods: Pair(), Connect(), Disconnect()
    //
    QDBusInterface deviceInterface(
        "org.bluez",
        devicePath,                 // path to THIS specific device
        "org.bluez.Device1",        // device interface (has Pair/Connect)
        QDBusConnection::systemBus()
        );

    // ============================================================
    // STEP 1: Pair if not already paired
    // ============================================================
    if (!paired) {
        qDebug() << "Device not paired. Pairing first...";

        QDBusMessage pairReply = deviceInterface.call("Pair");

        if (pairReply.type() == QDBusMessage::ErrorMessage) {
            // "AlreadyExists" means it's already paired — that's OK!
            if (pairReply.errorName().contains("AlreadyExists")) {
                qDebug() << "Already paired, continuing to connect...";
            } else {
                qWarning() << "Pairing failed:" << pairReply.errorMessage();
                emit connectionResult(false, "Pairing failed: " + pairReply.errorMessage());
                return;
            }
        } else {
            qDebug() << "Pairing successful!";
        }
    }

    // ============================================================
    // STEP 2: Connect
    // ============================================================
    qDebug() << "Connecting...";

    QDBusMessage connectReply = deviceInterface.call("Connect");

    if (connectReply.type() == QDBusMessage::ErrorMessage) {
        qWarning() << "Connection failed:" << connectReply.errorMessage();
        emit connectionResult(false, "Connection failed: " + connectReply.errorMessage());
        return;
    }

    qDebug() << "Connected to" << name << "successfully!";
    emit connectionResult(true, "Connected to " + name);

    // Update connected device name after a short delay
    QTimer::singleShot(1000, this, [this]() {
        updateConnectedDevice();
        // Also refresh the device list to update paired/connected status
        loadDevices();
    });
}


// ============================================================
// NEW: updateConnectedDevice()
// ============================================================
//
// Goes through all known devices and finds which one is connected
//
// Compare with WiFi:
//   WiFi:      Read ActiveAccessPoint → read its SSID
//   Bluetooth: Loop through all devices → check "Connected" property
//

void BluezManager::updateConnectedDevice()
{
    qDebug() << "=== updateConnectedDevice called ===";

    QDBusInterface objectManager(
        "org.bluez",
        "/",
        "org.freedesktop.DBus.ObjectManager",
        QDBusConnection::systemBus()
        );

    QDBusReply<ManagedObjectsMap> reply = objectManager.call("GetManagedObjects");

    if (!reply.isValid()) {
        qWarning() << "Failed to get managed objects:" << reply.error().message();
        m_connectedDevice = "";
        emit connectedDeviceChanged();
        return;
    }

    ManagedObjectsMap objects = reply.value();
    QString previousConnected = m_connectedDevice;
    m_connectedDevice = "";

    // Loop through all objects, looking for a connected device
    for (auto it = objects.constBegin(); it != objects.constEnd(); ++it) {
        QMap<QString, QVariantMap> interfaces = it.value();

        if (!interfaces.contains("org.bluez.Device1")) {
            continue;
        }

        QVariantMap props = interfaces["org.bluez.Device1"];
        bool connected = props.value("Connected", false).toBool();

        if (connected) {
            m_connectedDevice = props.value("Name", "").toString();
            qDebug() << "Connected Bluetooth device:" << m_connectedDevice;
            break;  // found it, stop looking
        }
    }

    if (m_connectedDevice.isEmpty()) {
        qDebug() << "No Bluetooth device connected";
    }

    // Only emit if the value actually changed
    if (m_connectedDevice != previousConnected) {
        emit connectedDeviceChanged();
    }
}
