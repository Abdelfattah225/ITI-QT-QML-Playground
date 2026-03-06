import QtQuick
import QtQuick.Controls
Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Column{
        spacing: 15
        anchors.centerIn: parent
        RangeSlider{
            id: rangeid
            from: 0
            to: 100
            first.value: 0
            second.value: 100
            stepSize: 5
        }
        Text {
            id: id
            text: rangeid.first.value
            font.pixelSize: 43
        }
        Text {
            id: id2
            text: rangeid.second.value
            font.pixelSize: 43
        }
    }
}
