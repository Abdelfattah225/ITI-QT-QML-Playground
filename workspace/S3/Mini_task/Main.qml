import QtQuick

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    Flow{
        anchors.centerIn: parent
        spacing: 5
        anchors.margins: 5
        flow: Flow.TopToBottom
        layoutDirection: "LeftToRight"

        MCard{
            id: card1
            cardtxt: "Card 1"
        }
        MCard{
            id: card2
            cardtxt: "Card 2"
            cardcol: "blue"
        }
        MCard{
            id: card3
            cardtxt: "Card 3"
            cardcol: "red"
        }
    }
    Connections{
        target: card1
        function onCardClicked(){
            console.log("Card 1 clicked")
        }
    }
    Connections{
        target: card2
        function onCardClicked(){
            console.log("Card 2 clicked")
        }
    }
    Connections{
        target: card3
        function onCardClicked(){
            console.log("Card 3 clicked")
        }
    }

}
