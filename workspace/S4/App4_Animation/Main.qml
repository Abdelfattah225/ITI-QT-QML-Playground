import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Window

Window {
    width: 640
    height: 480
    visible: true
    title: "Transformation"

    AbdoRectangle {
        id: rect1
        x: 50
        y: 100
        width: 100
        height: 100
        radius: 13
        color: "skyblue"

        onClicked: {
            scale += .1A
        }
    }
}
