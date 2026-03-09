
# Connectivity Control App

A Linux desktop application built with **Qt6/QML** and **C++** that provides a graphical interface to manage **WiFi** and **Bluetooth** connectivity using **D-Bus**.

![App Screenshot](screenshots/app.png)

---

## Features

### WiFi Panel
- **Toggle WiFi** ON/OFF via NetworkManager D-Bus API
- **Scan** for nearby WiFi networks
- **View** network details (name, signal strength, security status)
- **Connect** to WiFi networks (with password dialog for secured networks)
- **Visual indicator** (✅) showing currently connected network

### Bluetooth Panel
- **Toggle Bluetooth** ON/OFF via BlueZ D-Bus API
- **Scan** for nearby Bluetooth devices
- **View** device details (name, address, RSSI, paired/connected status)
- **Pair and Connect** to Bluetooth devices with one click
- **Visual indicator** (✅) showing currently connected device

---

## Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    Application                           │
│                                                          │
│  ┌──────────┐    ┌───────────────┐    ┌──────────────┐  │
│  │          │    │               │    │              │  │
│  │   QML    │◄──►│  WifiManager  │◄──►│ NetworkMgr   │  │
│  │   (UI)   │    │    (C++)      │    │  (D-Bus)     │  │
│  │          │    │               │    │              │  │
│  │          │    ├───────────────┤    ├──────────────┤  │
│  │          │    │               │    │              │  │
│  │          │◄──►│ BluezManager  │◄──►│   BlueZ      │  │
│  │          │    │    (C++)      │    │  (D-Bus)     │  │
│  │          │    │               │    │              │  │
│  └──────────┘    └───────────────┘    └──────────────┘  │
│                                                          │
└─────────────────────────────────────────────────────────┘
```

---

## Project Structure

```
Task03_Connectivity_Control/
├── CMakeLists.txt           # Build configuration
├── main.cpp                 # Application entry point
├── wifimanager.h            # WiFi manager header
├── wifimanager.cpp          # WiFi D-Bus logic
├── bluetoothmanager.h       # Bluetooth manager header
├── bluetoothmanager.cpp     # Bluetooth D-Bus logic
├── Main.qml                 # User interface
├── icons/
│   ├── wifi.svg             # WiFi icon
│   └── bluetooth.svg        # Bluetooth icon
└── README.md                # This file
```

---

## D-Bus Interfaces Used

### WiFi (NetworkManager)

| Action         | Service                          | Path                               | Interface                                          | Method/Property       |
|----------------|----------------------------------|------------------------------------|----------------------------------------------------|----------------------|
| Toggle ON/OFF  | org.freedesktop.NetworkManager   | /org/freedesktop/NetworkManager    | org.freedesktop.DBus.Properties                    | WirelessEnabled      |
| Find WiFi Device | org.freedesktop.NetworkManager | /org/freedesktop/NetworkManager    | org.freedesktop.NetworkManager                     | GetDevices()         |
| Scan Networks  | org.freedesktop.NetworkManager   | /org/.../Devices/X                 | org.freedesktop.NetworkManager.Device.Wireless     | RequestScan()        |
| Get Results    | org.freedesktop.NetworkManager   | /org/.../Devices/X                 | org.freedesktop.NetworkManager.Device.Wireless     | GetAccessPoints()    |
| Connect        | org.freedesktop.NetworkManager   | /org/freedesktop/NetworkManager    | org.freedesktop.NetworkManager                     | AddAndActivateConnection() |

### Bluetooth (BlueZ)

| Action         | Service    | Path              | Interface                              | Method/Property    |
|----------------|------------|--------------------|-----------------------------------------|-------------------|
| Toggle ON/OFF  | org.bluez  | /org/bluez/hci0   | org.freedesktop.DBus.Properties         | Powered           |
| Start Scan     | org.bluez  | /org/bluez/hci0   | org.bluez.Adapter1                      | StartDiscovery()  |
| Stop Scan      | org.bluez  | /org/bluez/hci0   | org.bluez.Adapter1                      | StopDiscovery()   |
| Get Devices    | org.bluez  | /                  | org.freedesktop.DBus.ObjectManager      | GetManagedObjects()|
| Pair           | org.bluez  | /org/bluez/hci0/dev_XX | org.bluez.Device1                   | Pair()            |
| Connect        | org.bluez  | /org/bluez/hci0/dev_XX | org.bluez.Device1                   | Connect()         |

---

## Prerequisites

- **Linux** (tested on Ubuntu)
- **Qt 6.8+** (with Quick, QuickControls2, DBus modules)
- **CMake 3.16+**
- **NetworkManager** (for WiFi management)
- **BlueZ** (for Bluetooth management)

---

## Build & Run

```bash
# Clone or navigate to the project
cd Task03_Connectivity_Control

# Create build directory
mkdir -p build && cd build

# Configure with CMake (adjust Qt path if needed)
cmake .. -DCMAKE_PREFIX_PATH=/home/your-user/Qt/6.10.2/gcc_64

# Build
make -j$(nproc)

# Run
./appTask03_Connectivity_Control
```

> **Note:** The app needs access to the system D-Bus. If you get permission errors, run with:
> ```bash
> sudo ./appTask03_Connectivity_Control
> ```

---

## Technologies Used

| Technology      | Purpose                              |
|----------------|--------------------------------------|
| Qt 6 / QML     | UI framework and declarative UI      |
| C++ 17         | Backend logic                        |
| D-Bus          | IPC with system services             |
| NetworkManager | WiFi hardware management             |
| BlueZ          | Bluetooth hardware management        |
| CMake          | Build system                         |

---

## Steps Completed

- [x] Step 1: Project skeleton + UI panels
- [x] Step 2: WiFi ON/OFF via D-Bus
- [x] Step 3: WiFi Scanning
- [x] Step 4: WiFi Connect (with password dialog)
- [x] Step 5: Bluetooth ON/OFF via D-Bus
- [x] Step 6: Bluetooth Scanning
- [x] Step 7: Bluetooth Pairing/Connect
- [ ] Step 8: Polish + Error Handling

---
