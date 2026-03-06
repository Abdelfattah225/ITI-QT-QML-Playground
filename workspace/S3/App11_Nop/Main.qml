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
    Text{
        id: txt
        text: qsTr(" ")
        font.pixelSize: 20
    }
       Dial{
           anchors.centerIn: parent
           from: 0
           to: 100
           onValueChanged: function(){
               txt.text =Math.round(value)
           }
       }
    }

}
