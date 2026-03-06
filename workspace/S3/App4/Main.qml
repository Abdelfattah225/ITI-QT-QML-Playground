import QtQuick
import QtQuick.Controls
Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Rectangle{
        id:rectId
        width: 200
        height: 200
        color: "red"
        MouseArea{
            id:mouseID
            anchors.fill: parent
            onClicked: {
                rectId.greeting("Hello Abdo")

            }

        }

        signal greeting(string msg)
        onGreeting: function(msg){
            console.log("msg: "+msg)
        }

        function myFunc(msg){
            console.log("I am abdelfattah, "+ msg)
        }

    }

    // when window complete
    Component.onCompleted: {
        // link function to be hander of the signal(connect signal to i
        rectId.greeting.connect(rectId.myFunc("hi"))
    }

}
