import QtQuick

Rectangle {
    id: root
    anchors.fill: parent
    color: "#1a1a2e"

    signal goBack()
    property var clubs: []
    property int selectedIndex: -1
    property int currentPage: 0
    property int clubsPerPage: 6

    Column {
        anchors.fill: parent
        spacing: 15
        padding: 20

        // HEADER
        Row {
            spacing: 20

            Rectangle {
                width: 100
                height: 40
                color: "#00ff85"
                radius: 8

                Text {
                    text: "← Back"
                    color: "#37003c"
                    font.bold: true
                    anchors.centerIn: parent
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: root.goBack()
                }
            }

            Text {
                text: "🏆 Premier League Clubs"
                color: "white"
                font.pixelSize: 28
                font.bold: true
            }
        }

        // CLUBS ROW WITH ARROWS
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10

            // LEFT ARROW
            Rectangle {
                width: 50
                height: 150
                color: currentPage > 0 ? "#00ff85" : "#333"
                radius: 10
                anchors.verticalCenter: parent.verticalCenter

                Text {
                    text: "◀"
                    color: currentPage > 0 ? "#37003c" : "#666"
                    font.pixelSize: 24
                    font.bold: true
                    anchors.centerIn: parent
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (currentPage > 0) {
                            currentPage--
                            selectedIndex = -1
                        }
                    }
                }
            }

            // CLUBS GRID
            Grid {
                columns: 6
                spacing: 10

                Repeater {
                    model: {
                        var start = currentPage * clubsPerPage
                        var end = Math.min(start + clubsPerPage, clubs.length)
                        var pageClubs = []
                        for (var i = start; i < end; i++) {
                            pageClubs.push({data: clubs[i], index: i})
                        }
                        return pageClubs
                    }

                    Rectangle {
                        width: 120
                        height: 150
                        color: selectedIndex === modelData.index ? modelData.data.color : "#2d2d44"
                        radius: 12
                        border.color: modelData.data.color
                        border.width: 2

                        Column {
                            anchors.centerIn: parent
                            spacing: 8

                            Image {
                                source: modelData.data.logo
                                width: 60
                                height: 60
                                fillMode: Image.PreserveAspectFit
                                anchors.horizontalCenter: parent.horizontalCenter
                            }

                            Text {
                                text: modelData.data.name
                                color: "white"
                                font.pixelSize: 10
                                font.bold: true
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: 100
                                horizontalAlignment: Text.AlignHCenter
                                elide: Text.ElideRight
                            }

                            Rectangle {
                                width: 30
                                height: 30
                                radius: 15
                                color: modelData.data.color
                                anchors.horizontalCenter: parent.horizontalCenter

                                Text {
                                    text: "#" + modelData.data.position
                                    color: "white"
                                    font.bold: true
                                    font.pixelSize: 10
                                    anchors.centerIn: parent
                                }
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: selectedIndex = modelData.index
                        }
                    }
                }
            }

            // RIGHT ARROW
            Rectangle {
                width: 50
                height: 150
                color: (currentPage + 1) * clubsPerPage < clubs.length ? "#00ff85" : "#333"
                radius: 10
                anchors.verticalCenter: parent.verticalCenter

                Text {
                    text: "▶"
                    color: (currentPage + 1) * clubsPerPage < clubs.length ? "#37003c" : "#666"
                    font.pixelSize: 24
                    font.bold: true
                    anchors.centerIn: parent
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if ((currentPage + 1) * clubsPerPage < clubs.length) {
                            currentPage++
                            selectedIndex = -1
                        }
                    }
                }
            }
        }

        // PAGE INDICATOR
        Text {
            text: "Page " + (currentPage + 1) + " of " + Math.ceil(clubs.length / clubsPerPage)
            color: "gray"
            font.pixelSize: 14
            anchors.horizontalCenter: parent.horizontalCenter
        }

        // CLUB DETAILS
        Rectangle {
            width: parent.width - 40
            height: 180
            color: "#2d2d44"
            radius: 15
            visible: selectedIndex >= 0
            anchors.horizontalCenter: parent.horizontalCenter

            Row {
                anchors.centerIn: parent
                spacing: 40

                // Club Logo
                Image {
                    source: selectedIndex >= 0 ? clubs[selectedIndex].logo : ""
                    width: 100
                    height: 100
                    fillMode: Image.PreserveAspectFit
                }

                Column {
                    spacing: 5
                    Text { text: "🏟️ Stadium"; color: "gray"; font.pixelSize: 12 }
                    Text { text: selectedIndex >= 0 ? clubs[selectedIndex].stadium : ""; color: "#00ff85"; font.pixelSize: 16; font.bold: true }
                }

                Column {
                    spacing: 5
                    Text { text: "🏆 Titles"; color: "gray"; font.pixelSize: 12 }
                    Text { text: selectedIndex >= 0 ? clubs[selectedIndex].titles.toString() : ""; color: "#00ff85"; font.pixelSize: 24; font.bold: true }
                }

                Column {
                    spacing: 5
                    Text { text: "🥇 FA Cups"; color: "gray"; font.pixelSize: 12 }
                    Text { text: selectedIndex >= 0 ? clubs[selectedIndex].cups.toString() : ""; color: "#00ff85"; font.pixelSize: 24; font.bold: true }
                }

                Column {
                    spacing: 5
                    Text { text: "🌍 Foreign"; color: "gray"; font.pixelSize: 12 }
                    Text { text: selectedIndex >= 0 ? clubs[selectedIndex].foreigners.toString() : ""; color: "#00ff85"; font.pixelSize: 24; font.bold: true }
                }

                Column {
                    spacing: 5
                    Text { text: "👔 Manager"; color: "gray"; font.pixelSize: 12 }
                    Text { text: selectedIndex >= 0 ? clubs[selectedIndex].manager : ""; color: "#00ff85"; font.pixelSize: 16; font.bold: true }
                }
            }
        }
    }
}
