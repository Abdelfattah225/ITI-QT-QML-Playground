import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    color: "#2b2b2b"
    ColumnLayout {
        anchors.fill: parent
        spacing: 20

        BusyIndicator {
            id: busyID
            running: true

            Layout.alignment: Qt.AlignHCenter
            // Layout.preferredWidth: 40
            // Layout.preferredHeight: 40
        }

        Button {
            text: "Run"
            Layout.alignment: Qt.AlignHCenter
            onClicked: busyID.running = true
        }

        Button {
            text: "Stop"
            Layout.alignment: Qt.AlignHCenter
            onClicked: busyID.running = false
        }
    }
}
