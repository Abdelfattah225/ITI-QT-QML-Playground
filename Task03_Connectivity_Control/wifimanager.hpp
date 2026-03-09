#ifndef WIFIMANAGER_HPP
#define WIFIMANAGER_HPP

#include <QObject>
#include <QDBusInterface>
#include <QDBusReply>
#include <QDBusVariant>
#include <QDBusObjectPath>
#include <QDBusMessage>
#include <QStringList>
#include <QVariantList>
#include <QVariantMap>
#include <QTimer>

class WifiManager : public QObject{
    Q_OBJECT
    Q_PROPERTY(bool wifiEnabled READ wifiEnabled WRITE setWifiEnabled NOTIFY wifiEnabledChanged)
    Q_PROPERTY(QVariantList networks READ networks NOTIFY networksChanged)
    Q_PROPERTY(bool scanning READ scanning NOTIFY scanningChanged)
    Q_PROPERTY(QString connectedSSID READ connectedSSID NOTIFY connectedSSIDChanged)  // ← NEW

public:
    explicit WifiManager(QObject *parent = nullptr);
    bool wifiEnabled() const;
    QVariantList networks() const;
    bool scanning() const;
    QString connectedSSID() const;  // ← NEW

    void setWifiEnabled(bool enabled);

    Q_INVOKABLE void scanNetworks();
    Q_INVOKABLE void connectToNetwork(const QString &ssid,
                                      const QString &password,
                                      const QString &apPath,
                                      bool secured);

signals:
    void wifiEnabledChanged();
    void networksChanged();
    void scanningChanged();
    void connectedSSIDChanged();                              // ← NEW
    void connectionResult(bool success, const QString &message);

private:
    bool readWifiState();
    QString findWifiDevice();
    void loadAccessPoints();
    void updateConnectedSSID();  // ← NEW

    bool m_wifiEnabled;
    bool m_scanning;
    QVariantList m_networks;
    QString m_wifiDevicePath;
    QString m_connectedSSID;     // ← NEW
    QDBusInterface *m_properties;
};
#endif
