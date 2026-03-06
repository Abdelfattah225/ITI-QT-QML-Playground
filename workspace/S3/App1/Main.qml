import QtQuick
import QtQuick.Controls

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("App")

    Column{
        spacing: 5
        anchors.centerIn: parent

        MButton{
            id:b1
            btnTxt: "IT_Smart_Village"
            btnCol: "blue"
            onBtnClicked: {
                console.log("ITI_Btn Clicked")
            }

        }
        MButton{
            id:b2
            btnTxt: "ITI_Cairo"
            onBtnClicked: {
                console.log("ITI_Btn Clicked")
            }

        }
        MButton{
            id:b3
            btnTxt: "ITI_alex"
            btnCol: "black"
            onBtnClicked: {
                console.log("ITI_Btn Clicked")
            }

        }
    }
}
