import QtQuick
import WeatherApp 1.0

Window {
    width: 480
    height: 620
    visible: true
    title: qsTr("Weather App")

    WeatherManager {
        id: weatherManager
    }

    Component.onCompleted: {
        weatherManager.fetchWeather("Dubai")
    }

    // Dark gradient background
    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#0a0f1e" }
            GradientStop { position: 1.0; color: "#0d2137" }
        }

        // Glass card
        Rectangle {
            width: parent.width * 0.88
            height: parent.height * 0.85
            anchors.centerIn: parent
            radius: 35
            color: Qt.rgba(1, 1, 1, 0.07)
            border.color: Qt.rgba(1, 1, 1, 0.15)
            border.width: 1

            Column {
                anchors.centerIn: parent
                spacing: 18
                width: parent.width * 0.85

                // ── Search Bar ──────────────────────────
                Rectangle {
                    width: parent.width
                    height: 45
                    radius: 25
                    color: Qt.rgba(1, 1, 1, 0.1)
                    border.color: Qt.rgba(1, 1, 1, 0.2)
                    border.width: 1

                    Row {
                        anchors.fill: parent
                        anchors.leftMargin: 15
                        anchors.rightMargin: 8
                        spacing: 8

                        Text {
                            text: "🔍"
                            font.pixelSize: 16
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        TextInput {
                            id: searchInput
                            width: parent.width - 100
                            height: parent.height
                            color: "white"
                            font.pixelSize: 15
                            verticalAlignment: TextInput.AlignVCenter
                            clip: true

                            // Placeholder
                            Text {
                                visible: searchInput.text === ""
                                text: "Search city..."
                                color: "#88aabb"
                                font.pixelSize: 15
                                anchors.verticalCenter: parent.verticalCenter
                            }

                            Keys.onReturnPressed: {
                                weatherManager.fetchWeather(searchInput.text)
                                searchInput.text = ""
                            }
                        }

                        // Search Button
                        Rectangle {
                            width: 70
                            height: 33
                            radius: 18
                            anchors.verticalCenter: parent.verticalCenter
                            color: "#4A90D9"

                            Text {
                                anchors.centerIn: parent
                                text: "Search"
                                color: "white"
                                font.pixelSize: 13
                                font.bold: true
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    weatherManager.fetchWeather(searchInput.text)
                                    searchInput.text = ""
                                }
                                onPressed: parent.color = "#2a70b9"
                                onReleased: parent.color = "#4A90D9"
                            }
                        }
                    }
                }

                // ── Right now in ────────────────────────
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Right now in"
                    font.pixelSize: 16
                    color: "#88aabb"
                    font.letterSpacing: 2
                }

                // ── City Name ───────────────────────────
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: weatherManager.cityName.toUpperCase()
                    font.pixelSize: 36
                    font.bold: true
                    color: "white"
                    font.letterSpacing: 3
                }

                // ── Description ─────────────────────────
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "it's " + weatherManager.weatherDescription
                    font.pixelSize: 16
                    color: "#88ccff"
                    font.italic: true
                }

                // ── Temperature ─────────────────────────
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: weatherManager.temperature.toFixed(1) + "°"
                    font.pixelSize: 90
                    font.bold: true
                    color: "white"
                }

                // ── Divider line ────────────────────────
                Rectangle {
                    width: parent.width
                    height: 1
                    color: Qt.rgba(1, 1, 1, 0.15)
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                // ── Wind & Humidity ─────────────────────
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 40

                    // Wind box
                    Column {
                        spacing: 5

                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: "💨"
                            font.pixelSize: 28
                        }
                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: weatherManager.windSpeed.toFixed(1)
                            font.pixelSize: 22
                            font.bold: true
                            color: "white"
                        }
                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: "m/s"
                            font.pixelSize: 13
                            color: "#88aabb"
                        }
                    }

                    // Vertical divider
                    Rectangle {
                        width: 1
                        height: 60
                        color: Qt.rgba(1, 1, 1, 0.15)
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    // Humidity box
                    Column {
                        spacing: 5

                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: "💧"
                            font.pixelSize: 28
                        }
                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: weatherManager.humidity
                            font.pixelSize: 22
                            font.bold: true
                            color: "white"
                        }
                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: "%"
                            font.pixelSize: 13
                            color: "#88aabb"
                        }
                    }
                }
            }
        }
    }
}
