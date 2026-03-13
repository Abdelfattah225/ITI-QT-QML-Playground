import QtQuick
import QtQuick.Dialogs
import QtQuick.Controls
Window {
    id: windowID
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Column{
        spacing: 15
        anchors.centerIn: parent
        Button{
            text: "open"
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: function(){
                msgDialogID.open()
            }

        }

        MessageDialog{
            id: msgDialogID
            title: "Msg"
            text: "Hello, I am ITIian"
            buttons: MessageDialog.Ok | MessageDialog.Cancel
            onAcceptedA: function(){
                console.log("Dialog is Ok")
            }
            onRejected: function(){
                console.log("Dialog is Cancled")
            }

        }
    }
}
