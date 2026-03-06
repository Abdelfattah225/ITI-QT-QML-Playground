import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    ColumnLayout{
        anchors.fill: parent
        spacing: 20

        BusyIndicator{
            id: busyID
            running: false
            Layout.alignment: Qt.AlignHCenter
        }

        Button {
            text: "Run"

            Layout.alignment: Qt.AlignHCenter

            onClicked: {
                busyID.running = true
            }
        }

        Button {
            text: "Stop"

            Layout.alignment: Qt.AlignHCenter

            onClicked: {
                busyID.running = false
            }
        }
    }
}
