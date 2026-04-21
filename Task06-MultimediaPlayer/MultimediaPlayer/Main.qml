import QtQuick
import QtMultimedia
import QtQuick.Dialogs
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

Window {
    width: 1000
    height: 650
    visible: true
    title: "Multimedia Player"
    color: "#1a1a2e"

    // Tracks which page is currently shown in StackLayout
    property int currentPage: 0

    // Main layout: Sidebar on left, Content on right
    RowLayout {
        anchors.fill: parent
        spacing: 0

        // Sidebar navigation panel
        Rectangle {
            Layout.preferredWidth: 180
            Layout.fillHeight: true
            color: "#16213e"

            Column {
                anchors.fill: parent
                spacing: 0

                // App logo/title area
                Rectangle {
                    width: parent.width
                    height: 80
                    color: "transparent"

                    Label {
                        anchors.centerIn: parent
                        text: "🎵 My Player"
                        font.pixelSize: 20
                        font.bold: true
                        color: "#e94560"
                    }
                }

                // Decorative separator line
                Rectangle {
                    width: parent.width - 20
                    height: 1
                    color: "#e94560"
                    anchors.horizontalCenter: parent.horizontalCenter
                    opacity: 0.3
                }

                // Spacer
                Item { width: 1; height: 15 }

                // Navigation buttons generated from array using Repeater
                Repeater {
                    model: [
                        { label: "🎬  Player",    index: 0 },
                        { label: "📻  Radio",     index: 1 },
                        { label: "💾  USB",       index: 2 }
                    ]

                    delegate: Rectangle {
                        width: parent.width
                        height: 55
                        // Active page gets accent color, hovered gets dark, others transparent
                        color: currentPage === modelData.index ? "#e94560" : mouseArea.containsMouse ? "#1a1a40" : "transparent"

                        // Smooth color transition animation
                        Behavior on color { ColorAnimation { duration: 200 } }

                        Label {
                            anchors.left: parent.left
                            anchors.leftMargin: 20
                            anchors.verticalCenter: parent.verticalCenter
                            text: modelData.label
                            font.pixelSize: 15
                            color: currentPage === modelData.index ? "white" : "#8899aa"
                            font.bold: currentPage === modelData.index
                        }

                        // Left accent bar for active page
                        Rectangle {
                            width: 4
                            height: parent.height
                            color: "#e94560"
                            visible: currentPage === modelData.index
                        }

                        // Click handler to switch pages
                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: currentPage = modelData.index
                        }
                    }
                }
            }
        }

        // Main content area that changes based on selected page
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#1a1a2e"

            // StackLayout shows only one child at a time based on currentIndex
            StackLayout {
                anchors.fill: parent
                anchors.margins: 15
                currentIndex: currentPage

                // ═══════════════════════════════
                // PAGE 0: MEDIA PLAYER
                // Plays local audio/video files
                // ═══════════════════════════════
                Item {
                    // Video display area fills space above controls
                    Rectangle {
                        id: videoArea
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: playerControls.top
                        anchors.bottomMargin: 10
                        color: "#0f3460"
                        radius: 12

                        // VideoOutput renders video frames from MediaPlayer
                        VideoOutput {
                            id: videoOutput
                            anchors.fill: parent
                            anchors.margins: 2
                            fillMode: VideoOutput.PreserveAspectFit
                        }

                        // Placeholder text shown when nothing is playing
                        Label {
                            anchors.centerIn: parent
                            text: "🎬 Open a file to play"
                            font.pixelSize: 18
                            color: "#556677"
                            visible: player.playbackState === MediaPlayer.StoppedState
                        }
                    }

                    // Player controls at bottom
                    Column {
                        id: playerControls
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottomMargin: 10
                        spacing: 10

                        // Progress bar: current time + slider + total time
                        RowLayout {
                            width: parent.width
                            spacing: 10

                            // Current playback position formatted as m:ss
                            Label {
                                text: formatTime(player.position)
                                color: "#8899aa"
                                font.pixelSize: 12
                            }

                            // Seekable progress slider
                            Slider {
                                id: progressSlider
                                Layout.fillWidth: true
                                from: 0
                                to: player.duration > 0 ? player.duration : 1
                                value: player.position
                                live: true

                                // Seek when user releases the slider
                                onPressedChanged: {
                                    if (!pressed) {
                                        player.position = value
                                    }
                                }

                                // Custom slider track
                                background: Rectangle {
                                    x: progressSlider.leftPadding
                                    y: progressSlider.topPadding + progressSlider.availableHeight / 2 - height / 2
                                    width: progressSlider.availableWidth
                                    height: 4
                                    radius: 2
                                    color: "#0f3460"

                                    // Filled portion showing progress
                                    Rectangle {
                                        width: progressSlider.visualPosition * parent.width
                                        height: parent.height
                                        color: "#e94560"
                                        radius: 2
                                    }
                                }

                                // Custom circular handle
                                handle: Rectangle {
                                    x: progressSlider.leftPadding + progressSlider.visualPosition * (progressSlider.availableWidth - width)
                                    y: progressSlider.topPadding + progressSlider.availableHeight / 2 - height / 2
                                    width: 16
                                    height: 16
                                    radius: 8
                                    color: "#e94560"
                                    border.color: "white"
                                    border.width: 2
                                }
                            }

                            // Total duration formatted as m:ss
                            Label {
                                text: formatTime(player.duration)
                                color: "#8899aa"
                                font.pixelSize: 12
                            }
                        }

                        // Playback control buttons generated from array
                        RowLayout {
                            width: parent.width
                            spacing: 10

                            Item { Layout.fillWidth: true }

                            Repeater {
                                model: [
                                    { icon: "📂", action: "open" },
                                    { icon: "⏮", action: "prev" },
                                    { icon: player.playbackState === MediaPlayer.PlayingState ? "⏸" : "▶", action: "play" },
                                    { icon: "⏹", action: "stop" },
                                    { icon: "⏭", action: "next" }
                                ]

                                delegate: Rectangle {
                                    width: 50
                                    height: 50
                                    radius: 25
                                    color: playBtnMouse.containsMouse ? "#e94560" : "#0f3460"

                                    Behavior on color { ColorAnimation { duration: 200 } }

                                    Label {
                                        anchors.centerIn: parent
                                        text: modelData.icon
                                        font.pixelSize: 20
                                    }

                                    MouseArea {
                                        id: playBtnMouse
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        cursorShape: Qt.PointingHandCursor
                                        onClicked: {
                                            if (modelData.action === "open") fileDialog.open()
                                            else if (modelData.action === "play") {
                                                if (player.playbackState === MediaPlayer.PlayingState)
                                                    player.pause()
                                                else
                                                    player.play()
                                            }
                                            else if (modelData.action === "stop") player.stop()
                                        }
                                    }
                                }
                            }

                            Item { Layout.fillWidth: true }
                        }

                        // Volume control row
                        RowLayout {
                            width: parent.width
                            spacing: 10
                            Item { Layout.fillWidth: true }
                            Label { text: "🔊"; font.pixelSize: 16 }

                            // Volume slider bound to AudioOutput
                            Slider {
                                id: volumeSlider
                                width: 120
                                from: 0
                                to: 1
                                value: 0.8

                                background: Rectangle {
                                    x: volumeSlider.leftPadding
                                    y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
                                    width: volumeSlider.availableWidth
                                    height: 3
                                    radius: 2
                                    color: "#0f3460"
                                    Rectangle {
                                        width: volumeSlider.visualPosition * parent.width
                                        height: parent.height
                                        color: "#e94560"
                                        radius: 2
                                    }
                                }
                                handle: Rectangle {
                                    x: volumeSlider.leftPadding + volumeSlider.visualPosition * (volumeSlider.availableWidth - width)
                                    y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
                                    width: 12
                                    height: 12
                                    radius: 6
                                    color: "#e94560"
                                }
                            }
                            Item { Layout.fillWidth: true }
                        }
                    }
                }

                // ═══════════════════════════════
                // PAGE 1: INTERNET RADIO
                // Streams audio from online radio URLs
                // ═══════════════════════════════
                Item {
                    Column {
                        anchors.fill: parent
                        spacing: 15

                        Label {
                            text: "📻 Internet Radio"
                            font.pixelSize: 26
                            font.bold: true
                            color: "#e94560"
                        }

                        Rectangle {
                            width: parent.width
                            height: 1
                            color: "#e94560"
                            opacity: 0.3
                        }

                        // Radio station list from ListModel
                        ListView {
                            id: radioListView
                            width: parent.width
                            height: parent.height - 120
                            model: radioStations
                            clip: true
                            spacing: 8

                            delegate: Rectangle {
                                width: radioListView.width
                                height: 60
                                radius: 10
                                color: radioMouse.containsMouse ? "#0f3460" : "#16213e"
                                border.color: radioListView.currentIndex === index ? "#e94560" : "transparent"
                                border.width: 2

                                Behavior on color { ColorAnimation { duration: 150 } }

                                RowLayout {
                                    anchors.fill: parent
                                    anchors.margins: 12
                                    spacing: 12

                                    // Station icon
                                    Rectangle {
                                        width: 36
                                        height: 36
                                        radius: 18
                                        color: "#e94560"
                                        Label {
                                            anchors.centerIn: parent
                                            text: "📻"
                                            font.pixelSize: 16
                                        }
                                    }

                                    // Station name from ListModel
                                    Label {
                                        text: model.name
                                        font.pixelSize: 16
                                        color: "white"
                                        Layout.fillWidth: true
                                    }

                                    // Play hint on hover
                                    Label {
                                        text: "▶ Play"
                                        color: "#e94560"
                                        font.pixelSize: 13
                                        visible: radioMouse.containsMouse
                                    }
                                }

                                // Click to set stream URL and play
                                MouseArea {
                                    id: radioMouse
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: {
                                        radioListView.currentIndex = index
                                        player.source = model.url
                                        player.play()
                                    }
                                }
                            }
                        }

                        // Stop radio button
                        Row {
                            spacing: 15
                            anchors.horizontalCenter: parent.horizontalCenter

                            Rectangle {
                                width: 100; height: 40; radius: 20
                                color: "#e94560"
                                Label { anchors.centerIn: parent; text: "⏹ Stop"; color: "white"; font.pixelSize: 14 }
                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: player.stop()
                                }
                            }
                        }
                    }
                }

                // ═══════════════════════════════
                // PAGE 2: USB MEDIA
                // Scans USB drives for media files using C++ USBManager
                // ═══════════════════════════════
                Item {
                    Column {
                        anchors.fill: parent
                        spacing: 15

                        Label {
                            text: "💾 USB Media"
                            font.pixelSize: 26
                            font.bold: true
                            color: "#e94560"
                        }

                        Rectangle {
                            width: parent.width
                            height: 1
                            color: "#e94560"
                            opacity: 0.3
                        }

                        // Scan button triggers C++ USBManager.scanForMedia()
                        Row {
                            spacing: 15
                            anchors.horizontalCenter: parent.horizontalCenter

                            Rectangle {
                                width: 150; height: 40; radius: 20
                                color: "#e94560"
                                Label { anchors.centerIn: parent; text: "🔄 Scan USB"; color: "white"; font.pixelSize: 14 }
                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: usbManager.scanForMedia()
                                }
                            }
                        }

                        // File list populated from C++ Q_PROPERTY mediaFiles
                        ListView {
                            id: usbFileList
                            width: parent.width
                            height: parent.height - 150
                            model: usbManager.mediaFiles
                            clip: true
                            spacing: 5

                            delegate: Rectangle {
                                width: usbFileList.width
                                height: 50
                                radius: 8
                                color: usbMouse.containsMouse ? "#0f3460" : "#16213e"

                                Behavior on color { ColorAnimation { duration: 150 } }

                                // Show only filename, not full path
                                Label {
                                    anchors.left: parent.left
                                    anchors.leftMargin: 15
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: modelData.split("/").pop()
                                    color: "white"
                                    font.pixelSize: 14
                                }

                                // Click to play file and switch to player page
                                MouseArea {
                                    id: usbMouse
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: {
                                        player.source = "file://" + modelData
                                        player.play()
                                        currentPage = 0
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // ═══════════════════════════════
    // SHARED COMPONENTS
    // Used across all pages
    // ═══════════════════════════════

    // MediaPlayer handles playback for files, streams, and USB
    MediaPlayer {
        id: player
        audioOutput: audioOutput
        videoOutput: videoOutput
    }

    // AudioOutput routes sound to speakers, volume bound to slider
    AudioOutput {
        id: audioOutput
        volume: volumeSlider.value
    }

    // System file picker filtered to media formats
    FileDialog {
        id: fileDialog
        title: "Choose Media File"
        nameFilters: ["Media files (*.mp3 *.wav *.ogg *.flac *.mp4 *.avi *.mkv)"]
        onAccepted: {
            player.source = fileDialog.selectedFile
            player.play()
        }
    }

    // Radio station data: name displayed in list, url used as stream source
    ListModel {
        id: radioStations
        ListElement { name: "تراتيل قصيرة متميزة"; url: "http://qurango.net/radio/tarateel" }
        ListElement { name: "إذاعة مشاري العفاسي"; url: "http://qurango.net/radio/mishary_alafasi" }
        ListElement { name: "مختصر التفسير"; url: "http://qurango.net/radio/mukhtasartafsir" }
        ListElement { name: "On Sport FM"; url: "https://carina.streamerr.co:2020/stream/OnSportFM" }
    }

    // Converts milliseconds to m:ss format for display
    function formatTime(ms) {
        var totalSeconds = Math.floor(ms / 1000)
        var minutes = Math.floor(totalSeconds / 60)
        var seconds = totalSeconds % 60
        return minutes + ":" + (seconds < 10 ? "0" : "") + seconds
    }
}
