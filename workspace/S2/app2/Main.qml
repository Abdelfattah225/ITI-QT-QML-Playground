import QtQuick

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    Column{
        id:colID
        anchors.centerIn: parent
        spacing: 20

        Text {
            id:time
            text: Qt.formatDateTime(new Date(),"dd/MM/yyyy - hh:mm:ss")
            font.pixelSize: 25
        }
        Text{
            text: "Locale: "+Qt.locale().name
            font.pixelSize: 30
        }
        Text{
            text: "Platform: "+Qt.platform.os
        }

        Rectangle{
            width:200
            height:200
            color: "green"
            Text {
                anchors.centerIn: parent
                text: "click to create dynamic"
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    dynamicRect.createObject(colID)
                }
            }
        }
        Component{
            id:dynamicRect
            Rectangle{
                width:233
                height:321
                color: "red"
                radius: 50
                Text {
                    anchors.centerIn: parent
                    text: qsTr("Dynamic Rect")
                }
            }
        }
    }
}
