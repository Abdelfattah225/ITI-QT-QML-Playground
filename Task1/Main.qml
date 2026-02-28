import QtQuick

Window {
    width: 800
    height: 600
    visible: true
    title: qsTr("Task 1")
        // ===== SPLASH SCREEN =====
    Rectangle{
        id: background
        color: "black"
        anchors.fill: parent
        visible: true

        Column{
         id:col1
         spacing: 20
         anchors.centerIn: parent
        Image {
            id: image1
            source: "splash.jpg"
            width: 500   // adjust as needed
            height: 400  // adjust as needed
            fillMode: Image.PreserveAspectFit  // keeps image ratio
        }
        Text {
            id: txt1
            text: qsTr("Loading...")
            color: "white"
            font.pixelSize: 24                // bigger text
            anchors.horizontalCenter: parent.horizontalCenter  // center text
         }
        }

    }
        // ===== HOME SCREEN =====
    Rectangle{
        id: homescreen
        anchors.fill: parent
        color: "darkblue"
        visible: false

        Text {
            id: txt2
            text: qsTr("Welcome to Home Screen!")
            anchors.centerIn: parent
            color: "white"
            font.pixelSize: 30
        }


    }

    Timer{
        interval: 3000
        running: true
        repeat: false

        onTriggered: {
            background.visible = false
            homescreen.visible = true
        }
    }

}
