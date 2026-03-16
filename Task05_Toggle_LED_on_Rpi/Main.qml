import QtQuick
import QtQuick.Controls
import LedControllerApp 1.0

Window {
    id: root
    width: 400
    height: 500
    visible: true
    title: "LED Controller"
    color: "#1a1a2e"

    // C++ backend instance
    LedController {
        id: ledController
    }

    // Card container
    Rectangle {
        id: card
        width: 300
        height: 350
        anchors.centerIn: parent
        radius: 20
        color: "#16213e"

        // Shadow effect
        Rectangle {
            anchors.fill: parent
            anchors.margins: -2
            radius: 22
            color: "#0f0f1a"
            z: -1
        }

        Column {
            anchors.centerIn: parent
            spacing: 30

            // LED Circle Indicator
            Rectangle {
                id: ledIndicator
                width: 100
                height: 100
                radius: 50
                anchors.horizontalCenter: parent.horizontalCenter
                color: ledController.LedState ? "#00ff88" : "#555555"

                // Glow effect when ON
                Rectangle {
                    visible: ledController.LedState
                    anchors.centerIn: parent
                    width: 120
                    height: 120
                    radius: 60
                    color: "transparent"
                    border.color: "#00ff88"
                    border.width: 2
                    opacity: 0.5
                }

                // Smooth color transition
                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }
            }

            // Status Text
            Text {
                id: statusText
                anchors.horizontalCenter: parent.horizontalCenter
                text: ledController.LedState ? "LED: ON" : "LED: OFF"
                font.pixelSize: 24
                font.bold: true
                color: ledController.LedState ? "#00ff88" : "#888888"

                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }
            }

            // Toggle Button
            Rectangle {
                id: toggleButton
                width: 200
                height: 60
                radius: 30
                anchors.horizontalCenter: parent.horizontalCenter
                color: buttonMouseArea.pressed ? "#0a4d3a" : "#0d7754"

                Text {
                    anchors.centerIn: parent
                    text: "TOGGLE LED"
                    font.pixelSize: 18
                    font.bold: true
                    color: "#ffffff"
                }

                MouseArea {
                    id: buttonMouseArea
                    anchors.fill: parent
                    onClicked: {
                        ledController.toggle()
                    }
                }

                // Button press animation
                Behavior on color {
                    ColorAnimation {
                        duration: 100
                    }
                }
            }
        }
    }
}
