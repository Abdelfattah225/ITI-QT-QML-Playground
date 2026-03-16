#ifndef LEDCONTROLLER_H
#define LEDCONTROLLER_H

#include <QObject>
#include <QString>

const int GPIO_BASE = 512;
const int GPIO_PIN = 17;
const int GPIO_NUM = GPIO_BASE + GPIO_PIN;  // = 529


class LedController : public QObject{
    Q_OBJECT
    Q_PROPERTY(bool LedState READ LedState WRITE setLedState NOTIFY LedStateChanged FINAL)

public:
    explicit LedController(QObject *parent = nullptr);

    // Getter
    bool LedState();

    // Setter
    void setLedState(bool value);

    Q_INVOKABLE void toggle();
signals:
    void LedStateChanged();

private:
    bool m_LedState;

    // Helper methods
    bool writeToFile(const QString &path, const QString &value);
    bool readFromFile(const QString &path);
};

#endif // LEDCONTROLLER_H
