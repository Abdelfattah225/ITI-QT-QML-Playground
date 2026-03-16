#include "LedController.h"
#include <QFile>

const QString GPIO_PATH = "/sys/class/gpio/gpio" + QString::number(GPIO_NUM);

LedController::LedController(QObject *parent) : QObject(parent){
    m_LedState = false;
    writeToFile("/sys/class/gpio/export", QString::number(GPIO_NUM));
    writeToFile(GPIO_PATH + "/direction", "out");
}

bool LedController::LedState(){
    m_LedState = readFromFile(GPIO_PATH + "/value");
    return m_LedState;
}

void LedController::setLedState(bool value){
    if(value == m_LedState){
        return;
    }
    m_LedState = value;
    writeToFile(GPIO_PATH + "/value", value ? "1" : "0");
    emit LedStateChanged();
}

bool LedController::writeToFile(const QString &path, const QString &value){
    QFile file(path);
    if(file.open(QIODevice::WriteOnly)){
        QByteArray data = value.toUtf8();
        file.write(data);
        file.close();
        return true;
    }
    else{
        return false;
    }
}

bool LedController::readFromFile(const QString &path){
    QFile file(path);
    if(file.open(QIODevice::ReadOnly)){
        QByteArray data = file.readAll();
        file.close();
        return data.trimmed() == "1";
    }
    return false;
}

void LedController::toggle(){
    setLedState(!m_LedState);
}
