
# QML Session 2 - Quick Reference

## 📦 Properties
```qml
property int myInt: 50
property bool isBool: true
property double myDouble: 50.5
property string message: "Hello"
```

## 🔗 Property Binding
```qml
width: rectwidth * 2  // Auto-updates when rectwidth changes
```

## 📢 Property Change Handler
```qml
property string message: "Hello"
onMessageChanged: {
    console.log("New value: " + message)
}
```

## 📐 Layouts
```qml
Row { spacing: 20 }     // Horizontal
Column { spacing: 20 }  // Vertical
```

## 🖱️ Mouse Interaction
```qml
MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    onClicked: { }
    onEntered: { }
    onExited: { }
}
```

## ⏱️ Timer
```qml
Timer {
    interval: 1000    // ms
    running: true
    repeat: true
    onTriggered: { }
}
```

## 🏭 Dynamic Object Creation
```qml
Component {
    id: myComponent
    Rectangle { }
}
// Usage:
myComponent.createObject(parentId)
```

## 🌐 Qt Global Object
```qml
Qt.formatDateTime(new Date(), "dd/MM/yyyy - hh:mm:ss")
Qt.locale().name
Qt.platform.os
```

## 🖼️ Image
```qml
Image {
    source: "qrc:/image.png"
    fillMode: Image.PreserveAspectFit
}
```

## 🔘 Button (QtQuick.Controls)
```qml
Button {
    text: "Click Me"
    onClicked: { }
}
```

