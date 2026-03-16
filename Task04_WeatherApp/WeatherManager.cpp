#include "WeatherManager.h"


WeatherManager::WeatherManager(QObject *parent ) : QObject(parent){
    m_temperature = 0;
    m_humidity = 0;
    m_windSpeed = 0;
    m_cityName = "Dubai";
    m_description = "clear";
    m_networkManager = new QNetworkAccessManager(this);
}

double WeatherManager::temperature(){
    return m_temperature;
}

int WeatherManager::humidity(){
    return m_humidity;
}
double WeatherManager::windSpeed(){
    return m_windSpeed;
}
QString WeatherManager::cityName(){
    return m_cityName;
}

// you forgot this!
QString WeatherManager::weatherDescription() {
    return m_description;
}

void WeatherManager::fetchWeather(QString city){
    // 1. build url
    QString url="https://api.openweathermap.org/data/2.5/weather?q="+ city + "&appid=bd5e378503939ddaee76f12ad7a97608&units=metric";
    // 2. create request with this url
    QNetworkRequest request;
    request.setUrl(QUrl(url));
    // 3. send request using m_networkManager
    // m_networkManager->get(request)
    // returns a QNetworkReply* (the response)

    QNetworkReply *reply = m_networkManager->get(request);

    connect(reply, &QNetworkReply::finished, this , [this, reply](){
        QByteArray data = reply->readAll();
        QJsonDocument doc = QJsonDocument::fromJson(data);
        QJsonObject json = doc.object();

        m_cityName          =json["name"].toString();
        m_temperature       =json["main"].toObject()["temp"].toDouble();
        m_humidity          =json["main"].toObject()["humidity"].toInt();
        m_windSpeed         =json["wind"].toObject()["speed"].toDouble();
        m_description       =json["weather"].toArray()[0].toObject()["description"].toString();

       emit cityNameChanged();
       emit temperatureChanged();
       emit humidityChanged();
       emit windSpeedChanged();
       emit weatherDescriptionChanged();

       reply->deleteLater();

    });
}



