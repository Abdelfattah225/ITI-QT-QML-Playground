import QtQuick
import QtQuick.Controls

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    // define custom property
    property string message: "Hello, World"

    // handler
    onMessageChanged: {
        console.log("Msg changed to : " + message)
    }

    Column {
        anchors.centerIn: parent
        spacing: 20

        Text {
            id: name
            text: qsTr(message)
        }

        Button {
            text: "Change Message"
            onClicked: {
                message = "message updated at "+new Date().toLocaleDateString()
            }
        }
    }
}
