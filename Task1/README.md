# Premier League Gallery App

A QML application showcasing Premier League clubs with their statistics.

---

## 📁 Project Structure

```
Task1/
├── Main.qml              # Main controller - manages screens
├── SplashScreen.qml      # Splash screen with video/animation
├── HomeScreen.qml        # Home screen with navigation buttons
├── GalleryScreen.qml     # Gallery showing all clubs
├── AboutScreen.qml       # About page
├── CMakeLists.txt        # Build configuration
├── splash.jpg            # Splash image
├── splash_new.mp4        # Splash video
└── images/               # Club logos
    ├── liverpool.png
    ├── arsenal.png
    ├── chelsea.png
    └── ...
```

---

## 🎯 Features

- ✅ Splash screen with video and loading animation
- ✅ Home screen with date/time display
- ✅ Gallery with all Premier League clubs
- ✅ Club details (stadium, titles, cups, manager)
- ✅ Navigation between screens
- ✅ Hover effects on buttons
- ✅ About page

---

## 📚 QML Concepts Used

### 1. Properties
```qml
property string currentScreen: "splash"
property int selectedIndex: -1
property var clubs: []
```

### 2. Signals
```qml
signal finished()
signal goToGallery()
signal goBack()
```

### 3. Property Binding
```qml
visible: currentScreen === "splash"
color: selectedIndex === index ? "green" : "gray"
```

### 4. Timer
```qml
Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: { }
}
```

### 5. Layouts
```qml
Row { }      // Horizontal
Column { }   // Vertical
Grid { }     // Grid layout
```

### 6. Repeater
```qml
Repeater {
    model: clubs
    Rectangle {
        Text { text: modelData.name }
    }
}
```

### 7. Anchors
```qml
anchors.fill: parent
anchors.centerIn: parent
anchors.horizontalCenter: parent.horizontalCenter
```

### 8. MouseArea
```qml
MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    onClicked: { }
    onEntered: { }
    onExited: { }
}
```

### 9. Animation
```qml
NumberAnimation on width {
    from: 0
    to: 300
    duration: 3000
}
```

---

## 🔄 Screen Navigation Flow

```
┌─────────────┐
│   Splash    │
│   Screen    │
└──────┬──────┘
       │ (after 4 seconds)
       ▼
┌─────────────┐
│    Home     │◄──────────────┐
│   Screen    │               │
└──────┬──────┘               │
       │                      │
   ┌───┴───┐                  │
   ▼       ▼                  │
┌──────┐ ┌──────┐             │
│Gallery│ │About │────────────┤
│Screen│ │Screen│  (Back)     │
└──────┘ └──────┘             │
    │                         │
    └─────────────────────────┘
           (Back)
```

---

## 🏃 How to Run

1. Open Qt Creator
2. Open `CMakeLists.txt`
3. Configure project
4. Build and Run

---

## 📝 Key Files Explained

### Main.qml
- Controls which screen is visible
- Holds clubs data
- Connects signals between screens

### SplashScreen.qml
- Shows video/image on startup
- Has loading bar animation
- Sends `finished()` signal when done

### HomeScreen.qml
- Shows date and time
- Has buttons for Gallery and About
- Sends `goToGallery()` and `goToAbout()` signals

### GalleryScreen.qml
- Displays all clubs using `Repeater`
- Shows club details when clicked
- Has navigation arrows for pagination

### AboutScreen.qml
- Shows app information
- Has back button

---

## 🎨 Colors Used

| Color | Hex Code | Usage |
|-------|----------|-------|
| Premier League Purple | `#37003c` | Background |
| Premier League Green | `#00ff85` | Buttons, highlights |
| Dark Background | `#1a1a2e` | Gallery background |
| Card Background | `#2d2d44` | Club cards |

---
## 🎬 Demo Video
[![Premier League App Demo](https://drive.google.com/thumbnail?id=1t3cEsLZlhbhwHiU74qFeRN4K_10yfhUu&sz=w1280)](https://drive.google.com/file/d/1t3cEsLZlhbhwHiU74qFeRN4K_10yfhUu/view?usp=sharing)
