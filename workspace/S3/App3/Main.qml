import QtQuick

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

        }
    }

    Connections{
        // handle signal of clicking
        target: mouseID
        function onClicked(){
            console.log("On Clicked");
        }
        function onDoubleClicked(mouse)
        {
            console.log("Double Clicking: "+mouse.x);
        }
    }
}
