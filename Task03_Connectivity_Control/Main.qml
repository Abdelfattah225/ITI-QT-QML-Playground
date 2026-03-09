import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    visible: true
    width: 800
    height: 500
    title: "Connectivity Control"
    color: "#1e1e2e"

    // ============================================================
    // PASSWORD DIALOG
    // ============================================================
    // This is a popup that appears when user clicks a secured network
    //
    // It stores the selected network's info in these properties:

    Dialog {
        id: passwordDialog
        title: "Connect to " + selectedSSID
        anchors.centerIn: parent
        modal: true           // blocks clicking behind the dialog
        standardButtons: Dialog.Ok | Dialog.Cancel

        // Store info about the network the user clicked
        property string selectedSSID: ""
        property string selectedPath: ""
        property bool selectedSecured: false

        ColumnLayout {
            spacing: 10

            Text {
                text: "Enter password for " + passwordDialog.selectedSSID
                color: "#333"
            }

            TextField {
                id: passwordField
                placeholderText: "Password"
                echoMode: TextInput.Password    // hides typed text with dots
                Layout.fillWidth: true
            }
        }

        // When user clicks OK
        onAccepted: {
            wifiManager.connectToNetwork(
                selectedSSID,
                passwordField.text,
                selectedPath,
                selectedSecured
            )
            passwordField.text = ""    // clear password field
        }

        // When user clicks Cancel
        onRejected: {
            passwordField.text = ""    // clear password field
        }
    }

    // ============================================================
    // RESULT MESSAGE (shows success/failure)
    // ============================================================
    Dialog {
        id: resultDialog
        title: "Connection Result"
        anchors.centerIn: parent
        modal: true
        standardButtons: Dialog.Ok

        property string resultMessage: ""

        Text {
            text: resultDialog.resultMessage
            color: "#333"
        }
    }

    // Listen for connection results from C++
    Connections {
        target: wifiManager
        function onConnectionResult(success, message) {
            resultDialog.resultMessage = message
            resultDialog.open()
        }
    }

    // ============================================================
    // MAIN LAYOUT (same as before, but network items are clickable)
    // ============================================================
    RowLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        // ========== WiFi Panel ==========
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 1
            radius: 15
            color: "#2e2e3e"

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 15

                Image {
                    Layout.alignment: Qt.AlignHCenter
                    source: "icons/wifi.svg"
                    width: 48; height: 48
                    sourceSize.width: 48; sourceSize.height: 48
                }
                Text {
                    text: "WiFi"
                    font.pixelSize: 28
                    color: "white"
                    Layout.alignment: Qt.AlignHCenter
                }
                Switch {
                    id: wifiSwitch
                    checked: wifiManager.wifiEnabled
                    onToggled: wifiManager.wifiEnabled = checked
                    Layout.alignment: Qt.AlignHCenter
                }
                Text {
                    text: wifiSwitch.checked ? "ON" : "OFF"
                    color: wifiSwitch.checked ? "green" : "gray"
                    font.pixelSize: 16
                    Layout.alignment: Qt.AlignHCenter
                }
                Button {
                    text: wifiManager.scanning ? "Scanning..." : "Scan Networks"
                    Layout.alignment: Qt.AlignHCenter
                    enabled: wifiSwitch.checked && !wifiManager.scanning
                    onClicked: wifiManager.scanNetworks()
                }

                ListView {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    clip: true
                    spacing: 5
                    visible: wifiSwitch.checked

                    model: wifiManager.networks

                    delegate: Rectangle {
                        width: ListView.view.width
                        height: 50
                        radius: 8
                        color: mouseArea.containsMouse ? "#4e4e5e" : "#3e3e4e"
                        //     ^^^^^^^^^^^^^^^^^^^^^^^^^
                        //     Changes color when mouse hovers! (visual feedback)

                        // ===== NEW: Make it clickable! =====
                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent
                            hoverEnabled: true      // track mouse hover
                            cursorShape: Qt.PointingHandCursor  // hand cursor

                            onClicked: {
                                if (modelData.secured) {
                                    // Secured network → show password dialog
                                    passwordDialog.selectedSSID = modelData.ssid
                                    passwordDialog.selectedPath = modelData.path
                                    passwordDialog.selectedSecured = true
                                    passwordDialog.open()
                                } else {
                                    // Open network → connect directly (no password)
                                    wifiManager.connectToNetwork(
                                        modelData.ssid,
                                        "",                // empty password
                                        modelData.path,
                                        false              // not secured
                                    )
                                }
                            }
                        }

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 10

                            Text {
                                text: modelData.secured ? "🔒" : "🔓"
                                font.pixelSize: 16
                            }
                            Text {
                                text: modelData.ssid
                                color: "white"
                                font.pixelSize: 14
                                Layout.fillWidth: true
                            }

                            // ===== NEW: Connected indicator =====
                            Text {
                                text: "✅"
                                font.pixelSize: 14
                                visible: modelData.ssid === wifiManager.connectedSSID
                                //       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                                //       Only shows if THIS network is the connected one
                            }

                            Text {
                                text: modelData.strength + "%"
                                color: "#aaa"
                                font.pixelSize: 12
                            }
                        }
                    }

                    Text {
                        anchors.centerIn: parent
                        text: "No networks found\nClick Scan"
                        color: "#666"
                        visible: wifiManager.networks.length === 0
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
            }
        }
        // ========== Bluetooth Panel ==========
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 1
            radius: 15
            color: "#2e2e3e"

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 15

                Image {
                    Layout.alignment: Qt.AlignHCenter
                    source: "icons/bluetooth.svg"
                    width: 48; height: 48
                    sourceSize.width: 48; sourceSize.height: 48
                }
                Text {
                    text: "Bluetooth"
                    color: "white"
                    font.pixelSize: 28
                    Layout.alignment: Qt.AlignHCenter
                }
                Switch {
                    id: bluetoothSwitch
                    checked: bluetoothManager.bluezPowered
                    onToggled: bluetoothManager.bluezPowered = checked
                    Layout.alignment: Qt.AlignHCenter
                }
                Text {
                    text: bluetoothSwitch.checked ? "ON" : "OFF"
                    color: bluetoothSwitch.checked ? "#2196F3" : "gray"
                    font.pixelSize: 16
                    Layout.alignment: Qt.AlignHCenter
                }
                Button {
                    text: bluetoothManager.scanning ? "Scanning..." : "Scan Devices"
                    Layout.alignment: Qt.AlignHCenter
                    enabled: bluetoothSwitch.checked && !bluetoothManager.scanning
                    onClicked: bluetoothManager.scanDevices()
                }

                ListView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true
                    spacing: 5
                    visible: bluetoothSwitch.checked

                    model: bluetoothManager.devices

                    delegate: Rectangle {
                        width: ListView.view.width
                        height: 55
                        radius: 8

                        // Green tint for connected device
                        color: modelData.name === bluetoothManager.connectedDevice
                               ? "#1a3a5a"     // blue tint for connected
                               : (btMouseArea.containsMouse ? "#4e4e5e" : "#3e3e4e")

                        // ===== Make it clickable! =====
                        MouseArea {
                            id: btMouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor

                            onClicked: {
                                bluetoothManager.connectToDevice(
                                    modelData.path,
                                    modelData.name,
                                    modelData.paired
                                )
                            }
                        }

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 10

                            // Status icon
                            Text {
                                text: modelData.connected ? "🔗"
                                      : (modelData.paired ? "✔" : "📱")
                                font.pixelSize: 16
                            }

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 2

                                Text {
                                    text: modelData.name
                                    color: "white"
                                    font.pixelSize: 14
                                }
                                Text {
                                    text: modelData.address
                                    color: "#888"
                                    font.pixelSize: 10
                                }
                            }

                            // Connected indicator
                            Text {
                                text: "✅"
                                font.pixelSize: 14
                                visible: modelData.name === bluetoothManager.connectedDevice
                            }

                            Text {
                                text: modelData.rssi + " dBm"
                                color: "#aaa"
                                font.pixelSize: 11
                            }
                        }
                    }

                    Text {
                        anchors.centerIn: parent
                        text: "No devices found\nClick Scan"
                        color: "#666"
                        visible: bluetoothManager.devices.length === 0
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
            }
        }
    }
}
