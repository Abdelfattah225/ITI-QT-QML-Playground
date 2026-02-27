import QtQuick
import QtQuick.Window

Window {
    width: 1000
    height: 500
    visible: true
    title: qsTr("Hello World")
    property int myInt: 50
    property bool isBool: true
    property double mydouble: 50.5
    property double rectwidth: 20.5
    property double recthieght: 20.5

    Row {
        spacing: 20
        anchors.centerIn: parent

        Rectangle {
            id: rect1
            width: rectwidth*2
            height: recthieght*2
            color: "blue"
            border.color: "black"
            border.width: 5

            Text {
                text: "Abdo"
                anchors.centerIn: parent
                font.bold: isBool
                font.pixelSize: 24
            }
        }

        Rectangle {
            id: rect2
            width: 200
            height: 200
            color: "blue"
            border.color: "black"
            border.width: 5

            Text {
                text: "Abdo"
                anchors.centerIn: parent
                font.bold: true
                font.pixelSize: 24
            }
        }

        Rectangle {
            id: rect3
            width: rectwidth*2
            height: recthieght*2
            color: "red"
            border.color: "black"
            border.width: 5

            Text {
                text: "Abdo"
                anchors.centerIn: parent
                font.bold: true
                font.pixelSize: 24
            }
            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    console.log("OnClicked green rect")
                    parent.color="gray"
                    recthieght+=10
                    rectwidth+=10
                }
                onHoveredChanged: {
                    parent.color= "purple"
                }
            }
        }
    }
}
