    import QtQuick

    Window {
        width: 640
        height: 480
        visible: true
        title: qsTr("Clock")

        property string currTime: ""
        Text {
            id: timeId
            anchors.centerIn: parent
            text: qsTr(currTime)
            font.bold: true
            font.pixelSize: 43
        }
        Timer{
            interval: 1000
            running: true
            repeat: true

            onTriggered: {
                var timenow=new Date()
                currTime=timenow.toLocaleTimeString()

            }
        }

    }
