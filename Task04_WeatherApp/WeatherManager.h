#ifndef WEATHERMANAGER_H
#define WEATHERMANAGER_H


#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QByteArray>
#include <QJsonObject>
#include <QJsonDocument>
#include <QJsonArray>

class WeatherManager : public QObject{
    Q_OBJECT // to make qml see my class

    Q_PROPERTY(double temperature READ temperature NOTIFY temperatureChanged)
    Q_PROPERTY(QString cityName READ cityName NOTIFY cityNameChanged)
    Q_PROPERTY(double windSpeed READ windSpeed NOTIFY windSpeedChanged)
    Q_PROPERTY(int humidity READ humidity NOTIFY humidityChanged)
    Q_PROPERTY(QString weatherDescription READ weatherDescription NOTIFY weatherDescriptionChanged)

public:
    explicit WeatherManager(QObject *parent = nullptr);
    //getter functions
    double temperature();
    double windSpeed();
    int humidity();
    QString cityName();
    QString weatherDescription();
    // setter
    // nothing
    Q_INVOKABLE void fetchWeather(QString city);


signals:

    void temperatureChanged();
    void cityNameChanged();
    void windSpeedChanged();
    void humidityChanged();
    void weatherDescriptionChanged();

private:
    double m_temperature;
    double m_windSpeed;
    int m_humidity;
    QString m_cityName;
    QString m_description;
    QNetworkAccessManager *m_networkManager;

};

#endif // WEATHERMANAGER_H
