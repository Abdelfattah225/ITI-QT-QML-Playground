import QtQuick
import QtQuick.Window

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Grid{
        anchors.fill: parent
        anchors.margins: 5
        spacing: 5
        flow: Flow.TopToBottom
        layoutDirection: "RightToLeft"
        Rectangle{
            id: rect1
            width: 350
            height: 200
            color: "red"
            Text {
                id: txt1
                text: "rect1"
                anchors.centerIn: parent
            }
        }

        Rectangle{
            id: rect2
            width: 350
            height: 200
            color: "green"
            Text {
                id: txt2
                text: "rect2"
                anchors.centerIn: parent
            }
        }

        Rectangle{
            id: rect3
            width: 350
            height: 200
            color: "blue"
            Text {
                id: txt3
                text: "rect3"
                anchors.centerIn: parent
            }
        }

        Rectangle{
            id: rect4
            width: 350
            height: 200
            color: "orange"
            Text {
                id: txt4
                text: "rect4"
                anchors.centerIn: parent
            }
        }

        Rectangle{
            id: rect5
            width: 350
            height: 200
            color: "purple"
            Text {
                id: txt5
                text: "rect5"
                anchors.centerIn: parent
            }
        }

        Rectangle{
            id: rect6
            width: 350
            height: 200
            color: "yellow"
            Text {
                id: txt6
                text: "rect6"
                anchors.centerIn: parent
            }
        }

        Rectangle{
            id: rect7
            width: 350
            height: 200
            color: "cyan"
            Text {
                id: txt7
                text: "rect7"
                anchors.centerIn: parent
            }
        }

        Rectangle{
            id: rect8
            width: 350
            height: 200
            color: "pink"
            Text {
                id: txt8
                text: "rect8"
                anchors.centerIn: parent
            }
        }
    }
}
