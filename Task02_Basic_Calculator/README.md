
# 🧮 Basic Calculator — Qt/QML

A simple calculator application built with **Qt 6** and **QML** as a learning project.

---

## 📸 Features

| Feature | Description |
|---------|-------------|
| ➕ Addition | Add two numbers |
| ➖ Subtraction | Subtract two numbers |
| ✖️ Multiplication | Multiply two numbers |
| ➗ Division | Divide two numbers |
| 🔢 Modulus (%) | Get remainder of division |
| ⌫ Delete | Remove last digit |
| 🗑️ Clear (C) | Reset calculator |
| 🎨 Hover Effects | Smooth color transitions on buttons |
| 📱 Press Animation | Buttons shrink on click |

---

## 🛠️ Tech Stack

- **Qt 6**
- **QML (Qt Quick)**
- **JavaScript** (embedded in QML for logic)

---

## 📁 Project Structure

```
BasicCalculator/
├── Main.qml           # Main window, display, grid layout & calculator logic
├── CalcButton.qml     # Reusable button component with hover/press effects
├── main.cpp           # Application entry point (auto-generated)
└── README.md          # This file
```

---

## 🎨 UI Layout

```
┌──────────────────────────────┐
│  ┌────────────────────────┐  │
│  │  Expression    5 + 3   │  │
│  │              Result: 8 │  │
│  └────────────────────────┘  │
│  ┌────┐ ┌────┐ ┌────┐ ┌────┐│
│  │ C  │ │ ⌫  │ │ %  │ │ ÷  ││
│  ├────┤ ├────┤ ├────┤ ├────┤│
│  │ 7  │ │ 8  │ │ 9  │ │ ×  ││
│  ├────┤ ├────┤ ├────┤ ├────┤│
│  │ 4  │ │ 5  │ │ 6  │ │ -  ││
│  ├────┤ ├────┤ ├────┤ ├────┤│
│  │ 1  │ │ 2  │ │ 3  │ │ +  ││
│  ├────┤ ├────┤ ├────┤ ├────┤│
│  │ 0  │ │ .  │ │ =  │ │ITI ││
│  └────┘ └────┘ └────┘ └────┘│
└──────────────────────────────┘
```


## 📖 QML Concepts Covered

This project was built as a learning exercise. Here are the key QML concepts used:

| Concept | Where Used |
|---------|-----------|
| `ApplicationWindow` | Main window |
| `Rectangle` | Display area, buttons |
| `Text` | Display text, button labels |
| `Column` | Vertical layout |
| `Grid` | Button grid (4 columns) |
| `MouseArea` | Button click & hover detection |
| `anchors` | Positioning elements |
| `property` | Custom variables (displayText, operators) |
| `signal` | Button click communication |
| `Behavior` | Smooth animations |
| `Qt.lighter()` | Dynamic hover colors |
| Custom Components | CalcButton.qml |
| JavaScript in QML | Calculator logic |


---

## 👨‍💻 Author

**Abdelfattah** — Built while learning Qt/QML
