import QtQuick

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Rectangle{
        id: rectid
        width: 200
        height: 300
        color : "red"
        MouseArea{
            anchors.fill: parent
            onClicked: {
                console.log("rect clicked")

            }
            onDoubleClicked: {
                console.log("Rect Double Clicked")
            }
            onEntered: {
                console.log("In Rect")
            }
            onExited: {
                console.log("out Rect")
            }
            // when dragging and then released:
            onReleased: {
                console.log("release at " + mouse.x,mouse.y)
            }
        }
    }
}
