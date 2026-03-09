#include "wifimanager.hpp"
#include <QDebug>
#include <QDBusConnection>
#include <QDBusArgument>

WifiManager::WifiManager(QObject * parent) : QObject(parent), m_scanning(false){
        // Create D-Bus interface to NetworkManager's Properties
        // org.freedesktop.DBus.Properties lets us Get/Set
        // any property on NetworkManager
        m_properties = new QDBusInterface(
            "org.freedesktop.NetworkManager",
            "/org/freedesktop/NetworkManager",           // path
            "org.freedesktop.DBus.Properties",           // interface
            QDBusConnection::systemBus(), this
            );
        m_wifiEnabled = readWifiState();
        qDebug() << "Initial WiFi state:" << m_wifiEnabled;

        // Find the WiFi device path (e.g., /org/freedesktop/.../Devices/2)
        m_wifiDevicePath = findWifiDevice();
        qDebug() << "WiFi device path:" << m_wifiDevicePath;
}

bool WifiManager::readWifiState(){
    // Call the "Get" method on DBus.Properties
    // Arguments: interface name, property name
    // It returns a QDBusVariant containing the value
    QDBusReply<QVariant> reply= m_properties->call(
        "Get",
        "org.freedesktop.NetworkManager",
        "WirelessEnabled"
        );
    if(reply.isValid())
        return reply.value().toBool();
    else{
        qWarning() << "Faild to read wifi state" << reply.error().message();
        return false;
    }
}


bool WifiManager::wifiEnabled() const{
    return m_wifiEnabled;
}

void WifiManager::setWifiEnabled(bool enabled){
    // Don't do anything if value hasn't changed
    if(m_wifiEnabled==enabled)
        return;

    // Call "Set" on DBus.Properties to change WirelessEnabled
    //
    // Set needs 3 arguments:
    //   1. Interface name: "org.freedesktop.NetworkManager"
    //   2. Property name:  "WirelessEnabled"
    //   3. New value:      wrapped in QDBusVariant
     QDBusMessage reply = m_properties->call(
        "Set",
        "org.freedesktop.NetworkManager",
        "WirelessEnabled",
        QVariant::fromValue(QDBusVariant(enabled))
        );


    if (reply.type() == QDBusMessage::ErrorMessage) {
        qWarning() << "D-Bus Error:" << reply.errorName();
        qWarning() << "Message:" << reply.errorMessage();
        return;
    }
    m_wifiEnabled = enabled;

    emit wifiEnabledChanged();

    qDebug() << "WiFi set to : " << m_wifiEnabled;

}


// ==================== Scanning ====================


bool WifiManager::scanning() const
{
    return m_scanning;
}
QVariantList WifiManager::networks() const
{
    return m_networks;
}



QString WifiManager::findWifiDevice()
{
    // 1. Create interface to NetworkManager (not Properties!)
    QDBusInterface nmInterface(
        "org.freedesktop.NetworkManager",          // service
        "/org/freedesktop/NetworkManager",          // path
        "org.freedesktop.NetworkManager",          // interface (the NM one, not Properties)
        QDBusConnection::systemBus()
        );

    // 2. Call GetDevices → returns list of paths
    QDBusReply<QList<QDBusObjectPath>> reply = nmInterface.call("GetDevices");

    if (!reply.isValid()) {
        qWarning() << "Failed to get devices:" << reply.error().message();
        return QString();
    }

    // 3. Loop through each device
    for (const QDBusObjectPath &devicePath : reply.value()) {

        // 3a. Create Properties interface for THIS device
        QDBusInterface deviceProps(
            "org.freedesktop.NetworkManager",          // service
             devicePath.path(),                         // path
            "org.freedesktop.DBus.Properties",
          QDBusConnection::systemBus()
            );

        // 3b. Read DeviceType
        QDBusReply<QVariant> typeReply = deviceProps.call(
            "Get",
            "org.freedesktop.NetworkManager.Device",    // which interface has DeviceType?
            "DeviceType"     // property name
            );

        // 3c. If type == 2, it's WiFi! Return the path
        if (typeReply.isValid() && typeReply.value().toUInt() == 2) {
            return devicePath.path();
        }
    }

    qWarning() << "No WiFi device found!";
    return QString();
}

void WifiManager::scanNetworks()
{
    // 1. Guard: don't scan if no WiFi device was found
    if (m_wifiDevicePath.isEmpty()) {
        qWarning() << "No WiFi device available";
        return;
    }

    // 2. Tell QML: "scanning started!"
    m_scanning = true;
    emit scanningChanged();

    // 3. Create interface to WiFi device's Wireless features
    QDBusInterface wirelessInterface(
        "org.freedesktop.NetworkManager",              // service
        m_wifiDevicePath,              // path (which device?)
        "org.freedesktop.NetworkManager.Device.Wireless",              // interface (Wireless one)
        QDBusConnection::systemBus()
        );

    // 4. Tell NetworkManager: "Scan the air!"
    QVariantMap options;
    wirelessInterface.call("RequestScan", options);

    // 5. Wait 3 seconds, then read results
    QTimer::singleShot(3000, this, [this]() {
        loadAccessPoints();          // read the found networks
        m_scanning = false;    // scanning is done
        emit scanningChanged();     // tell QML
    });
}


void WifiManager::loadAccessPoints()
{
    // 1. Clear old results
    m_networks.clear();

    // 2. Create Wireless interface and get list of APs
    QDBusInterface wirelessInterface(
        "org.freedesktop.NetworkManager",              // service
        m_wifiDevicePath,              // path (which device?)
        "org.freedesktop.NetworkManager.Device.Wireless",              // interface (Wireless one)
        QDBusConnection::systemBus()
        );

    QDBusReply<QList<QDBusObjectPath>> reply = wirelessInterface.call("GetAccessPoints");

    if (!reply.isValid()) {
        qWarning() << "Failed to get APs:" << reply.error().message();
        emit networksChanged();
        return;
    }

    // 3. Loop through each access point
    for (const QDBusObjectPath &apPath : reply.value()) {

        // 3a. Create Properties interface for THIS access point
        QDBusInterface apProps(
            "org.freedesktop.NetworkManager",              // service
            apPath.path(),              // path (use apPath — how do you get the string?)
            "org.freedesktop.DBus.Properties",              // interface (Properties)
            QDBusConnection::systemBus()
            );

        // 3b. Read Ssid
        QDBusReply<QVariant> ssidReply = apProps.call(
            "Get",
            "org.freedesktop.NetworkManager.AccessPoint",
            "Ssid"   // property name
            );

        // 3c. Read Strength
        QDBusReply<QVariant> strengthReply = apProps.call(
            "Get",
            "org.freedesktop.NetworkManager.AccessPoint",
            "Strength"
            );

        // 3d. Read WpaFlags (security)
        QDBusReply<QVariant> securityReply = apProps.call(
            "Get",
            "org.freedesktop.NetworkManager.AccessPoint",
            "WpaFlags"
            );

        // 3e-3g. Build the network map and add to list
        if (ssidReply.isValid()) {
            // Convert bytes to string
            QString ssid = QString::fromUtf8(ssidReply.value().toByteArray());

            // Skip hidden networks (empty name)
            if (ssid.isEmpty()) continue;

            // Build map
            QVariantMap network;
            network["ssid"] = ssid;
            network["strength"] = strengthReply.isValid()
                                      ? strengthReply.value().toUInt() : 0;
            network["secured"] = securityReply.isValid()
                                     ? (securityReply.value().toUInt() > 0) : false;
            network["path"] = apPath.path();

            // Add to list
             m_networks.append(network);
        }
    }

    // 4. Tell QML the data changed
    emit networksChanged();
    qDebug() << "Found" << m_networks.size() << "networks";
}



void WifiManager::connectToNetwork(const QString &ssid,
                                   const QString &password,
                                   const QString &apPath,
                                   bool secured)
{
    qDebug() << "Connecting to:" << ssid;

    // ============================================================
    // STEP 1: Build the connection settings map
    // ============================================================
    // This is a nested map: section name → properties
    // Type: QMap<QString, QVariantMap>
    //
    // Think of it like a form with sections:
    //   Section "connection":              general info
    //   Section "802-11-wireless":         WiFi-specific info
    //   Section "802-11-wireless-security": password info

    QVariantMap connectionSettings;
    connectionSettings["id"] = ssid;                    // connection name
    connectionSettings["type"] = "802-11-wireless";     // it's WiFi

    QVariantMap wirelessSettings;
    wirelessSettings["ssid"] = ssid.toUtf8();           // SSID as bytes
    //                         ^^^^^^^^^^^
    //                         Same as how we READ it — Ssid is always bytes!

    // Build the full settings map
    QMap<QString, QVariantMap> settings;
    settings["connection"] = connectionSettings;
    settings["802-11-wireless"] = wirelessSettings;

    // ============================================================
    // STEP 2: Add security settings IF the network is secured
    // ============================================================
    if (secured && !password.isEmpty()) {
        QVariantMap securitySettings;
        securitySettings["key-mgmt"] = "wpa-psk";      // WPA password type
        securitySettings["psk"] = password;             // the actual password
        settings["802-11-wireless-security"] = securitySettings;

        // Also tell the wireless section that security is used
        wirelessSettings["security"] = "802-11-wireless-security";
        settings["802-11-wireless"] = wirelessSettings;  // update it
    }

    // ============================================================
    // STEP 3: Convert to D-Bus argument type
    // ============================================================
    // D-Bus needs: a{sa{sv}}
    // Which means: map of (string → map of (string → variant))
    // QDBusArgument lets us build this exact format

    QDBusArgument settingsArg;
    settingsArg.beginMap(QMetaType::fromType<QString>(),
                         QMetaType::fromType<QVariantMap>());

    for (auto it = settings.constBegin(); it != settings.constEnd(); ++it) {
        settingsArg.beginMapEntry();
        settingsArg << it.key() << it.value();
        settingsArg.endMapEntry();
    }
    settingsArg.endMap();

    // ============================================================
    // STEP 4: Call AddAndActivateConnection
    // ============================================================
    QDBusInterface nmInterface(
        "org.freedesktop.NetworkManager",
        "/org/freedesktop/NetworkManager",
        "org.freedesktop.NetworkManager",
        QDBusConnection::systemBus()
        );

    // Arguments:
    //   1. settings    → the connection configuration we built
    //   2. device path → our WiFi device
    //   3. AP path     → the specific access point to connect to
    QDBusMessage reply = nmInterface.call(
        "AddAndActivateConnection",
        QVariant::fromValue(settingsArg),                    // settings
        QVariant::fromValue(QDBusObjectPath(m_wifiDevicePath)), // device
        QVariant::fromValue(QDBusObjectPath(apPath))           // access point
        );

    // ============================================================
    // STEP 5: Check result and notify QML
    // ============================================================
    if (reply.type() == QDBusMessage::ErrorMessage) {
        qWarning() << "Connection failed:" << reply.errorMessage();
        emit connectionResult(false, "Connection failed: " + reply.errorMessage());
    } else {
        qDebug() << "Connection initiated successfully!";
        emit connectionResult(true, "Connected to " + ssid);
    }
}


void WifiManager::updateConnectedSSID()
{
    // ============================================================
    // Read which Access Point we're currently connected to
    // ============================================================
    //
    // The WiFi device has a property "ActiveAccessPoint"
    // It returns the PATH of the AP we're connected to
    // Or "/" if not connected
    //

    if (m_wifiDevicePath.isEmpty()) {
        m_connectedSSID = "";
        emit connectedSSIDChanged();
        return;
    }

    // Step 1: Read ActiveAccessPoint from WiFi device
    QDBusInterface deviceProps(
        "org.freedesktop.NetworkManager",
        m_wifiDevicePath,
        "org.freedesktop.DBus.Properties",
        QDBusConnection::systemBus()
        );

    QDBusReply<QVariant> apReply = deviceProps.call(
        "Get",
        "org.freedesktop.NetworkManager.Device.Wireless",
        "ActiveAccessPoint"
        );

    if (!apReply.isValid()) {
        qWarning() << "Failed to get active AP:" << apReply.error().message();
        m_connectedSSID = "";
        emit connectedSSIDChanged();
        return;
    }

    // Step 2: Get the path
    // The reply contains a QDBusObjectPath wrapped in QVariant
    QDBusObjectPath activePath = qvariant_cast<QDBusObjectPath>(apReply.value());
    QString activePathStr = activePath.path();

    // "/" means not connected to anything
    if (activePathStr == "/" || activePathStr.isEmpty()) {
        m_connectedSSID = "";
        emit connectedSSIDChanged();
        return;
    }

    // Step 3: Read the SSID of the active access point
    QDBusInterface apProps(
        "org.freedesktop.NetworkManager",
        activePathStr,
        "org.freedesktop.DBus.Properties",
        QDBusConnection::systemBus()
        );

    QDBusReply<QVariant> ssidReply = apProps.call(
        "Get",
        "org.freedesktop.NetworkManager.AccessPoint",
        "Ssid"
        );

    if (ssidReply.isValid()) {
        m_connectedSSID = QString::fromUtf8(ssidReply.value().toByteArray());
    } else {
        m_connectedSSID = "";
    }

    emit connectedSSIDChanged();
    qDebug() << "Currently connected to:" << m_connectedSSID;
}


// ← ADD HERE
QString WifiManager::connectedSSID() const {
    return m_connectedSSID;
}
