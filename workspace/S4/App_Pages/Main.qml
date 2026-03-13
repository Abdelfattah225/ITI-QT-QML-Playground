import QtQuick
import QtQuick.Window
import QtQuick.Controls

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    StackView {
        id: sv
        anchors.fill: parent
        initialItem: homepageid
    }

    Page {
        id: homepageid
    header: null  // Disable the default header
        Rectangle {
            anchors.fill: parent
            color: "lightblue"

            Column {
                anchors.centerIn: parent
                spacing: 29

                Text {
                    text: qsTr("Home page")
                    font.bold: true
                    font.pixelSize: 32
                }

                Button {
                    text: "Go to second page"
                    onClicked: {
                        sv.push(secondpage)
                    }
                }
            }
        }
    }

    Page {
        id: secondpage
        header: null  // Disable the default header
        Rectangle {
            anchors.fill: parent
            color: "lightgreen"

            Column {
                anchors.centerIn: parent
                spacing: 29

                Text {
                    text: qsTr("Second page")
                    font.pixelSize: 23
                    font.bold: true
                }

                Button {
                    text: "Go to 1st page"
                    onClicked: {
                        sv.pop()
                    }
                }
            }
        }
    }
}
