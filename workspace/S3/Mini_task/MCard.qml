import QtQuick

Item {
    id: cardid
    signal cardClicked()
    implicitHeight: rect.height
    implicitWidth: rect.width

    property alias cardtxt: txt.text
    property alias cardcol: rect.color
    Rectangle{
        id: rect
        width: txt.width+20
        height: txt.height+20
        radius: 8
        color: "yellow"
        Text {
            anchors.centerIn: parent
            id: txt
            text: qsTr("Card")
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                cardid.cardClicked()
            }
        }

    }
}
