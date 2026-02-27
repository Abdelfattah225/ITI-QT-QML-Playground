import QtQuick

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("clock")

    Item{
        id:img
        width:1080
        height:1080
        // os dependent very bad
        Image{
            id:img1
            width:640
            height: 480
            source: "qrc:/myphoto.jpeg"
        }
    }


}
