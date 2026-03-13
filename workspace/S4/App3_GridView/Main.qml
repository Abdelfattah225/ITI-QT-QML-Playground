import QtQuick
import QtQuick.Window

Window {
    width: 640
    height: 480
    visible: true
    title: "Color Dialog"

    // Model: list of data
    ListModel {
        id: dataModelId

        ListElement { number: 1; mycolor: "red" }
        ListElement { number: 2; mycolor: "green" }
        ListElement { number: 3; mycolor: "black" }
        ListElement { number: 4; mycolor: "blue" }
        ListElement { number: 5; mycolor: "pink" }
        ListElement { number: 6; mycolor: "gray" }
        ListElement { number: 7; mycolor: "silver" }
        ListElement { number: 8; mycolor: "pink" }
        ListElement { number: 9; mycolor: "gold" }
        ListElement { number: 10; mycolor: "navy" }
    }

    GridView {
        id: gridID
        anchors.fill: parent
        model: dataModelId

        // cellWidth: 200
        // cellHeight: 200
       flow: GridView.FlowTopToBottom

        delegate: Rectangle {
            width:
            height: 180
            radius: 15
            color: mycolor

            Text {
                anchors.centerIn: parent
                text: number.toString()
                font.pixelSize: 20
                color: "white"
            }
        }
    }
}
