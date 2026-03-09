#ifndef BLUETOOTHMANAGER_H
#define BLUETOOTHMANAGER_H
#include <QDBusInterface>
#include <QDBusVariant>
#include <QDBusReply>
#include <QDBusMessage>
#include <QDBusObjectPath>
#include <QDebug>
#include <QObject>
#include <QVariantList>
#include <QVariantMap>
#include <QTimer>

class BluezManager : public QObject{
    Q_OBJECT
    Q_PROPERTY(bool bluezPowered READ bluezPowered WRITE setBluezPowered NOTIFY bluezPoweredChanged)
    Q_PROPERTY(QVariantList devices READ devices NOTIFY devicesChanged)
    Q_PROPERTY(bool scanning READ scanning NOTIFY scanningChanged)
    Q_PROPERTY(QString connectedDevice READ connectedDevice NOTIFY connectedDeviceChanged)  // ← NEW

public:
    explicit BluezManager(QObject *parent = nullptr);
    bool bluezPowered() const;
    void setBluezPowered(bool enabled);
    QVariantList devices() const;
    bool scanning() const;
    QString connectedDevice() const;  // ← NEW

    Q_INVOKABLE void scanDevices();
    Q_INVOKABLE void connectToDevice(const QString &devicePath,   // ← NEW
                                     const QString &name,
                                     bool paired);

signals:
    void bluezPoweredChanged();
    void devicesChanged();
    void scanningChanged();
    void connectedDeviceChanged();                                  // ← NEW
    void connectionResult(bool success, const QString &message);    // ← NEW

private:
    bool readBluezState();
    void loadDevices();
    void updateConnectedDevice();  // ← NEW

    bool m_bluezPowered;
    bool m_scanning;
    QVariantList m_devices;
    QString m_connectedDevice;     // ← NEW: name of connected device
    QDBusInterface *m_properties;
};
#endif
