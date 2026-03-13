import QtQuick

Rectangle {
    id: rootid

    signal clicked()

    MouseArea {
        anchors.fill: parent
        onClicked: rootid.clicked()
    }
}
