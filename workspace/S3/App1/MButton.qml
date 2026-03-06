import QtQuick

Item {
    id:rootId

    implicitWidth: buttonid.width
    implicitHeight: buttonid.height


    signal btnClicked
    property alias btnTxt: btnTxtId.text
    property alias btnCol: buttonid .color

    Rectangle{
        id: buttonid

        width: btnTxtId.implicitWidth + 10
        height: btnTxtId.implicitHeight + 10
        anchors.centerIn: parent
        color: "Yellow"
        Text{
            id: btnTxtId
            text: qsTr("Button")
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill: parent
            onClicked:{
                // fire my custom signal
                rootId.btnClicked()
            }
        }
    }
}
