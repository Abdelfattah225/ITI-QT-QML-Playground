import QtQuick
import QtQuick.Window
import QtQuick.Controls

Window {
    id: root
    width: 640
    height: 480
    visible: true
    title: "Animation"

    property bool running: true

    Rectangle {
        id: containerID
        anchors.fill: parent
        color: "skyblue"

        Rectangle {
            id: containedID
            width: 150
            height: 150
            radius: 15
            x: 50
            y: 100
            color: "green"

            PropertyAnimation on x {
                to: 500
                duration: 4000
            }

            NumberAnimation on y {
                to: 600
                duration: 2000
                running: root.running
            }

            RotationAnimation on rotation {
                to: 600
                duration: 2000
                running: root.running
            }
        }
    }

    Row {
        spacing: 20
        anchors.centerIn: parent

        // Start Animation
        Button {
            id: startanimation
            text: "Start Animation"
            onClicked: {
                root.running = true
            }
        }

        // Stop Animation
        Button {
            id: endani
            text: "Stop Animation"
            onClicked: {
                root.running = false
            }
        }

        // Reset Animation
        Button {
            id: rstani
            text: "Reset Animation"
            onClicked: {
                containedID.x = 50
                containedID.y = 100
                containedID.rotation = 0
                root.running = false
            }
        }
    }
}
