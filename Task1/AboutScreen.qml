import QtQuick

Rectangle {
    id: root
    anchors.fill: parent
    color: "#37003c"

    signal goBack()

    Column {
        anchors.centerIn: parent
        spacing: 25

        Text {
            text: "ℹ️ About This App"
            color: "#00ff85"
            font.pixelSize: 36
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Rectangle {
            width: 500
            height: 250
            color: "#2d2d44"
            radius: 15
            anchors.horizontalCenter: parent.horizontalCenter

            Column {
                anchors.centerIn: parent
                spacing: 15

                Text {
                    text: "Premier League Club Gallery"
                    color: "white"
                    font.pixelSize: 22
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "This application displays Premier League clubs\nwith their statistics including league titles,\nFA cups, current position, and foreign players."
                    color: "lightgray"
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "━━━━━━━━━━━━━━━━━━━━━━"
                    color: "#00ff85"
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "Version: 1.0"
                    color: "gray"
                    font.pixelSize: 14
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "Developed by: Abdo | ITI Qt Course"
                    color: "gray"
                    font.pixelSize: 14
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }

        // BACK BUTTON
        Rectangle {
            width: 150
            height: 50
            color: "#00ff85"
            radius: 10
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                text: "← Back Home"
                color: "#37003c"
                font.bold: true
                font.pixelSize: 16
                anchors.centerIn: parent
            }

            MouseArea {
                anchors.fill: parent
                onClicked: root.goBack()
            }
        }
    }
}
