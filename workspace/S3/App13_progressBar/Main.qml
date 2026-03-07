import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Window {
    width: 640
    height: 480
    visible: true
    title: "ProgressBar Animation"

    Column {
        spacing: 15
        anchors.centerIn: parent

        ProgressBar {
            id: barid
            from: 0
            to: 100
            value: 0
            width: 400
            indeterminate: false

        }

        Button {
            text: "Start Progress"
            onClicked: progressAnim.start()
        }
    }

    NumberAnimation {
        id: progressAnim
        target: barid           // Animate the ProgressBar
        property: "value"       // Property to animate
        from: 0
        to: 100
        duration: 3000          // 3 seconds
    }
}
