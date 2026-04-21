# 🎵 Qt Multimedia Player

A multimedia player application built with **Qt6 QML** and **C++** backend, supporting local media playback, internet radio streaming, and USB media detection.

---

## 🎬 Demo Video
[![Watch Demo Video](https://img.shields.io/badge/▶_Watch_Demo-Google_Drive-4285F4?style=for-the-badge&logo=googledrive&logoColor=white)](https://drive.google.com/file/d/16uhUm0IEggQXa1Btl1A466UnxUuM09gj/view?usp=sharing)

> **[Click here to watch the full demo video on Google Drive](https://drive.google.com/file/d/16uhUm0IEggQXa1Btl1A466UnxUuM09gj/view?usp=sharing)**

---

## 📋 Features

| Feature | Description |
|---------|-------------|
| 🎬 **Media Player** | Play local audio and video files with seek, volume, and playback controls |
| 📻 **Internet Radio** | Stream live radio stations from online URLs |
| 💾 **USB Media** | Auto-detect and browse media files from USB drives |
| 📶 **Bluetooth** | Placeholder for future Bluetooth audio support |

---

## 🛠️ Tech Stack

- **Qt 6.8** — Application framework
- **QML** — Declarative UI
- **C++** — Backend logic (USB detection)
- **CMake** — Build system
- **GStreamer** — Multimedia backend on Linux

---

## 📁 Project Structure

```
MultimediaPlayer/
├── CMakeLists.txt        # Build configuration, links Qt6::Quick and Qt6::Multimedia
├── main.cpp              # App entry point, exposes C++ objects to QML
├── Main.qml              # Full UI: sidebar navigation + 4 pages
├── usbmanager.h          # C++ header: USB detection and media scanning
├── usbmanager.cpp         # C++ implementation: filesystem watching and file listing
└── README.md             # This file
```

---

## 🏗️ Architecture

### UI Navigation
- **StackLayout** with 4 pages controlled by `currentIndex`
- Sidebar buttons switch pages by changing a `currentPage` property

### QML ↔ C++ Communication
- **Q_PROPERTY** — Exposes `mediaFiles` list from C++ to QML
- **Q_INVOKABLE** — Allows QML to call `scanForMedia()` C++ function
- **setContextProperty** — Registers C++ object globally in QML

### Media Playback
- **MediaPlayer** — Handles both local files and network streams
- **AudioOutput** — Routes audio, volume controlled by slider
- **VideoOutput** — Renders video frames with `PreserveAspectFit`

---

## 📻 Internet Radio

The app streams audio from direct stream URLs, not websites.

| Station | URL |
|---------|-----|
| تراتيل قصيرة متميزة | `http://qurango.net/radio/tarateel` |
| إذاعة مشاري العفاسي | `http://qurango.net/radio/mishary_alafasi` |
| مختصر التفسير | `http://qurango.net/radio/mukhtasartafsir` |
| On Sport FM | `https://carina.streamerr.co:2020/stream/OnSportFM` |

> MediaPlayer treats stream URLs the same as local files — just set `source` and call `play()`.

---

## 💾 USB Media Detection

### How It Works
1. **QFileSystemWatcher** monitors `/media/<username>/` for changes
2. When a USB drive is plugged in, the directory changes and triggers a signal
3. **QDirIterator** recursively scans the USB drive for media files (`.mp3`, `.mp4`, `.wav`)
4. File list is exposed to QML via **Q_PROPERTY**
5. User clicks a file → sets `player.source` and plays

### Supported Formats
`*.mp3` `*.mp4` `*.wav` `*.ogg` `*.flac` `*.avi` `*.mkv`

---


## 📌 Interview Q&A

**Q: What backend does Qt6 Multimedia use on Linux?**
A: GStreamer

**Q: What's the difference between MediaPlayer and AudioOutput in Qt6?**
A: MediaPlayer controls playback (source, play, pause). AudioOutput controls audio routing and volume. They are separate to allow flexible output routing (speakers, Bluetooth, etc.)

**Q: How does internet radio work in your app?**
A: Radio stations are direct audio stream URLs. MediaPlayer handles HTTP streaming internally through GStreamer.

**Q: How do you detect USB drives?**
A: QFileSystemWatcher monitors `/media/<user>/`. When a drive is mounted, it triggers `directoryChanged` signal, then QDirIterator scans for media files.

**Q: How does QML communicate with C++?**
A: Through Q_PROPERTY (read data), Q_INVOKABLE (call functions), and signals (notify changes). The C++ object is exposed via `setContextProperty`.


## 👨‍💻 Author

Abdelfattah
