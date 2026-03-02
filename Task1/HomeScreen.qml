import QtQuick

Rectangle {
    id: root
    anchors.fill: parent
    color: "#37003c"

    signal goToGallery()
    signal goToAbout()

    property string currTime: ""

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: currTime = Qt.formatDateTime(new Date(), "hh:mm:ss")
    }

    // BACKGROUND IMAGE
    Image {
        id: bgImage
        anchors.fill: parent
        source: "file:///home/abdo/Workspace/ITI/12-QT/ITI-QT-QML-Playground/Task1/premierleague1.jpeg"
        fillMode: Image.PreserveAspectCrop
    }

    // DARK OVERLAY (makes text readable)
    Rectangle {
        anchors.fill: parent
        color: "#37003c"
        opacity: 0.7
    }

    Column {
        anchors.centerIn: parent
        spacing: 30

        // HEADER
        Row {
            spacing: 40
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                text: "📅 " + Qt.formatDateTime(new Date(), "dd/MM/yyyy")
                color: "white"
                font.pixelSize: 16
            }
            Text {
                text: "🕐 " + currTime
                color: "white"
                font.pixelSize: 16
            }
        }

        // LOGO / TITLE
        Text {
            text: "⚽ PREMIER LEAGUE"
            color: "#00ff85"
            font.pixelSize: 48
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: "Club Gallery & Statistics"
            color: "white"
            font.pixelSize: 20
            anchors.horizontalCenter: parent.horizontalCenter
        }

        // SPACER
        Item { width: 1; height: 50 }

        // BUTTONS
        Row {
            spacing: 40
            anchors.horizontalCenter: parent.horizontalCenter

            // GALLERY BUTTON
            Rectangle {
                width: 200
                height: 60
                color: "#00ff85"
                radius: 10

                Text {
                    text: "🏆 View Gallery"
                    color: "#37003c"
                    font.pixelSize: 20
                    font.bold: true
                    anchors.centerIn: parent
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: parent.color = "#00cc6a"
                    onExited: parent.color = "#00ff85"
                    onClicked: root.goToGallery()
                }
            }

            // ABOUT BUTTON
            Rectangle {
                width: 200
                height: 60
                color: "transparent"
                radius: 10
                border.color: "#00ff85"
                border.width: 2

                Text {
                    text: "ℹ️ About"
                    color: "#00ff85"
                    font.pixelSize: 20
                    font.bold: true
                    anchors.centerIn: parent
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: parent.color = "#00ff8520"
                    onExited: parent.color = "transparent"
                    onClicked: root.goToAbout()
                }
            }
        }
    }
}
