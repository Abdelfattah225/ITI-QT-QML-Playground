
# LED Controller - Qt/QML Application for Raspberry Pi

A modern Qt/QML desktop application to control an LED connected to a Raspberry Pi GPIO pin.

---


## 🎬 Demo Video
[![Watch Demo Video](https://img.shields.io/badge/▶_Watch_Demo-Google_Drive-4285F4?style=for-the-badge&logo=googledrive&logoColor=white)](https://drive.google.com/file/d/1cx0EEFOUdrrSBwzhvuu09ZoQG9W1YE4a/view?usp=drive_link)

> **[Click here to watch the full demo video on Google Drive](https://drive.google.com/file/d/1cx0EEFOUdrrSBwzhvuu09ZoQG9W1YE4a/view?usp=drive_link)**


## 📋 Features

- Toggle button to turn LED ON/OFF
- Visual indicator showing LED current state
- Clean modern UI with animations
- Direct GPIO control via sysfs

---

## 🛠️ Hardware Requirements

- Raspberry Pi 3B+
- LED
- 330Ω resistor
- Breadboard and jumper wires

### Wiring Diagram

```
RPi GPIO17 (Pin 11) ----[330Ω]----[LED+]----[LED-]---- GND (Pin 6)
```

---

## 📁 Project Structure

```
Task05_Toggle_LED_on_Rpi/
├── CMakeLists.txt
├── main.cpp
├── LedController.h
├── LedController.cpp
├── Main.qml
└── README.md
```

---

## 🔧 GPIO Configuration

This project uses **sysfs** to control GPIO.

| Setting | Value |
|---------|-------|
| GPIO Pin | 17 |
| GPIO Base (Pi 3B+) | 512 |
| GPIO Number | 529 (512 + 17) |
| sysfs Path | `/sys/class/gpio/gpio529/` |

---

## 🚀 Building the Project

### Option A: Cross-Compile on PC

#### 1. Install Cross-Compiler (Ubuntu)

```bash
# For 64-bit Raspberry Pi OS
sudo apt install gcc-aarch64-linux-gnu g++-aarch64-linux-gnu

# For 32-bit Raspberry Pi OS
sudo apt install gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf
```

#### 2. Create Sysroot from Raspberry Pi

```bash
mkdir -p ~/rpi-qt/sysroot

# Replace PI_IP with your Pi's IP address
rsync -avz pi@PI_IP:/lib ~/rpi-qt/sysroot/
rsync -avz pi@PI_IP:/usr/include ~/rpi-qt/sysroot/usr/
rsync -avz pi@PI_IP:/usr/lib ~/rpi-qt/sysroot/usr/
```

#### 3. Build Project

```bash
mkdir build && cd build
cmake .. -DCMAKE_TOOLCHAIN_FILE=path/to/toolchain.cmake
cmake --build .
```

#### 4. Deploy to Raspberry Pi

```bash
scp Task05_Toggle_LED_on_Rpi pi@PI_IP:~/
```

---

### Option B: Build Directly on Raspberry Pi

#### 1. Install Dependencies on Pi

```bash
sudo apt update
sudo apt install -y qt6-base-dev qt6-declarative-dev
sudo apt install -y qml6-module-qtquick qml6-module-qtquick-controls
sudo apt install -y cmake ninja-build
```

#### 2. Transfer Source Code to Pi

```bash
scp -r Task05_Toggle_LED_on_Rpi pi@PI_IP:~/
```

#### 3. Build on Pi

```bash
cd ~/Task05_Toggle_LED_on_Rpi
mkdir build && cd build
cmake ..
cmake --build .
```

---

## ▶️ Running the Application

### Set GPIO Permissions

```bash
# Option 1: Run with sudo
sudo ./Task05_Toggle_LED_on_Rpi

# Option 2: Add user to gpio group (recommended)
sudo usermod -aG gpio $USER
# Logout and login again, then:
./Task05_Toggle_LED_on_Rpi
```

### View GUI via VNC

1. Enable VNC on Raspberry Pi:
   ```bash
   sudo raspi-config
   # Navigate to: Interface Options → VNC → Enable
   ```

2. Connect from PC using VNC Viewer

3. Run the application on Pi

---

## 📸 Screenshots

```
┌─────────────────────────────────┐
│         LED Controller          │
│  ┌───────────────────────────┐  │
│  │                           │  │
│  │         ◯ (gray)          │  │
│  │        LED: OFF           │  │
│  │                           │  │
│  │    ┌───────────────┐      │  │
│  │    │  TOGGLE LED   │      │  │
│  │    └───────────────┘      │  │
│  │                           │  │
│  └───────────────────────────┘  │
└─────────────────────────────────┘
```

---

## 📝 Code Overview

### LedController.h

```cpp
class LedController : public QObject {
    Q_OBJECT
    Q_PROPERTY(bool LedState READ LedState WRITE setLedState NOTIFY LedStateChanged)

public:
    explicit LedController(QObject *parent = nullptr);
    bool LedState();
    void setLedState(bool value);
    Q_INVOKABLE void toggle();

signals:
    void LedStateChanged();

private:
    bool m_LedState;
    bool writeToFile(const QString &path, const QString &value);
    bool readFromFile(const QString &path);
};
```

### Key QML Bindings

```qml
// LED indicator color changes based on state
color: ledController.LedState ? "#00ff88" : "#555555"

// Button calls C++ toggle method
onClicked: ledController.toggle()
```

---

## 🐛 Troubleshooting

| Problem | Solution |
|---------|----------|
| Permission denied on GPIO | Run with `sudo` or add user to `gpio` group |
| GPIO folder not created | Check if export value is correct (529 for GPIO17) |
| QML module not found | Install Qt QML modules on Pi |
| App crashes on start | Check if GPIO pin is already exported |

### Check GPIO Status

```bash
# See exported GPIOs
ls /sys/class/gpio/

# Check pin direction
cat /sys/class/gpio/gpio529/direction

# Check pin value
cat /sys/class/gpio/gpio529/value
```

### Manual GPIO Test

```bash
# Export pin
echo 529 | sudo tee /sys/class/gpio/export

# Set direction
echo out | sudo tee /sys/class/gpio/gpio529/direction

# Turn LED ON
echo 1 | sudo tee /sys/class/gpio/gpio529/value

# Turn LED OFF
echo 0 | sudo tee /sys/class/gpio/gpio529/value
```

---

## 📚 Technologies Used

- **Qt 6** - Application framework
- **QML** - UI markup language
- **C++** - Backend logic
- **sysfs** - GPIO control interface
- **CMake** - Build system

---

## 👨‍💻 Author

Abdelfattah
