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

        CheckBox{
            text: "select 1"
            checked: false
            enabled: false
            onCheckedChanged: function(){
                if(checked)
                {
                    console.log("checked")
                }
                else{
                    console.log("unchecked")
                }
            }
        }
    }
}
