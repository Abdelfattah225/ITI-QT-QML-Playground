import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    ColumnLayout{
        width: parent.width

        ComboBox{
            model: ["cat", "dog", "bird"]
            onActivated: {
                console.log(currentIndex+" "+currentText)
            }
        }
    }

}
