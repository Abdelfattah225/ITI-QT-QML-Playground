import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    ColumnLayout {
        anchors.fill: parent
        spacing: 10

        SwipeView {
            id: swipid
            Layout.fillWidth: true
            Layout.fillHeight: true
            currentIndex: indicatorID.currentIndex

            Rectangle {
                color: "red"
                radius: 8
                Layout.fillWidth: true
                Layout.fillHeight: true

                Text {
                    text: "Page 1"
                    anchors.centerIn: parent
                    font.pixelSize: 30
                    color: "white"
                }
            }

            Rectangle {
                color: "blue"
                radius: 8
                Layout.fillWidth: true
                Layout.fillHeight: true

                Text {
                    text: "Page 2"
                    anchors.centerIn: parent
                    font.pixelSize: 30
                    color: "white"
                }
            }

            Rectangle {
                color: "yellow"
                radius: 8
                Layout.fillWidth: true
                Layout.fillHeight: true

                Text {
                    text: "Page 3"
                    anchors.centerIn: parent
                    font.pixelSize: 30
                    color: "black"
                }
            }
        }

        // PageIndicator should be outside SwipeView
        PageIndicator {
            id: indicatorID
            count: swipid.count
            currentIndex: swipid.currentIndex
            Layout.alignment: Qt.AlignHCenter
        }
    }
}
