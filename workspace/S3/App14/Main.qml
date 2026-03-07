import QtQuick
import QtQuick.Controls
Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    color: "#2b2b2b"

    Column{
        spacing: 15
        anchors.centerIn: parent
        Text {
            id: wi
            text: qsTr("text")
        }
        Switch{
            id:switch1
            text: "wifi"
            onCheckedChanged: {
                if(checked){
                    wi.text="Wifi ON"
                }
                else{
                    wi.text="wifi off"
                }
            }
        }
    }
}
