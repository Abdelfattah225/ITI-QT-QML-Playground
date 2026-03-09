import QtQuick
import QtMultimedia

Rectangle {
    id: root
    anchors.fill: parent
    color: "#0f0f23"

    signal finished()

    Timer {
        id: finishTimer
        interval: 500
        onTriggered: root.finished()
    }

    Timer {
        interval: 9000
        running: true
        onTriggered: root.finished()
    }

    // FULLSCREEN VIDEO
    Video {
        id: splashVideo
        anchors.fill: parent
        source: "file:///home/abdo/Workspace/ITI/12-QT/ITI-QT-QML-Playground/Task1/splash_new.mp4"
        autoPlay: true
        loops: 1
        fillMode: VideoOutput.PreserveAspectCrop

        onPlaybackStateChanged: {
            if (playbackState === MediaPlayer.StoppedState) {
                finishTimer.start()
            }
        }
    }

    // Dark overlay at bottom for text visibility
    Rectangle {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 120
        gradient: Gradient {
            GradientStop { position: 0.0; color: "transparent" }
            GradientStop { position: 1.0; color: "#000000" }
        }
    }

    // Loading text
    Text {
        text: "⚽ Loading Premier League..."
        color: "#00ff85"
        font.pixelSize: 24
        font.bold: true
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: loadingBarBg.top
        anchors.bottomMargin: 15
    }

    // Loading bar
    Rectangle {
        id: loadingBarBg
        width: 350
        height: 6
        color: "#333"
        radius: 3
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 40

        Rectangle {
            height: parent.height
            color: "#00ff85"
            radius: 3

            NumberAnimation on width {
                from: 0
                to: 350
                duration: 8000
            }
        }
    }
}
