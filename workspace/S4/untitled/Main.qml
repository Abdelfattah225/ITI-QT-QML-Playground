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
            text: "select Color"
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: function(){
                colorDialogId.open()
            }

        }

        ColorDialog{
            id: colorDialogId
            title: "Color Dialog"
            onAccepted: function(){
                console.log("Selected Color: "+selectedColor)
                windowID.color=selectedColor
            }
            onRejected: function(){
                console.log("Dialog is cancled")
                windowID.color=selectedColor
            }
        }
    }
}
