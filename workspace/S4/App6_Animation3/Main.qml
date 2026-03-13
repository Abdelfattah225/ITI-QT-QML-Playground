import QtQuick

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    Rectangle{
        id: rectid
        width: 100
        height: 100
        radius: 32
        color: "pink"
        anchors.centerIn: parent

        ColorAnimation {
            id:col
            target: rectid
            from: "black"
            property: "color"
            to: "yellow"
            duration: 200
        }
    }
    MouseArea{
        anchors.fill: parent
        onClicked: function(){
        col.start()
        }
    }
}
