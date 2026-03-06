import QtQuick
import QtQuick.Window
import QtQuick.Layouts

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    GridLayout{
        columns: 4
        anchors.fill: parent
        anchors.margins: 5

        rowSpacing: 5
        columnSpacing: 5

        flow: GridLayout.TopToBottom
        layoutDirection: Qt.RightToLeft

        Rectangle{
            Layout.preferredWidth: 150
            Layout.preferredHeight: 100
            color: "red"
            Text { text: "rect1"; anchors.centerIn: parent }
        }

        Rectangle{
            Layout.preferredWidth: 150
            Layout.preferredHeight: 100
            color: "green"
            Text { text: "rect2"; anchors.centerIn: parent }
        }

        Rectangle{
            Layout.preferredWidth: 150
            Layout.preferredHeight: 100
            color: "blue"
            Text { text: "rect3"; anchors.centerIn: parent }
        }

        Rectangle{
            Layout.preferredWidth: 150
            Layout.preferredHeight: 100
            color: "orange"
            Text { text: "rect4"; anchors.centerIn: parent }
        }

        Rectangle{
            Layout.preferredWidth: 150
            Layout.preferredHeight: 100
            color: "purple"
            Text { text: "rect5"; anchors.centerIn: parent }
        }

        Rectangle{
            Layout.preferredWidth: 150
            Layout.preferredHeight: 100
            color: "yellow"
            Text { text: "rect6"; anchors.centerIn: parent }
        }

        Rectangle{
            Layout.preferredWidth: 150
            Layout.preferredHeight: 100
            color: "cyan"
            Text { text: "rect7"; anchors.centerIn: parent }
        }

        Rectangle{
            Layout.preferredWidth: 150
            Layout.preferredHeight: 100
            color: "pink"
            Text { text: "rect8"; anchors.centerIn: parent }
        }
    }
}
