
# Part 2: Task Breakdown

## 📋 Understanding the Task


```
┌─────────────────────────────────────────────────────────────┐
│                      PHASE 1                                │
│                   SPLASH SCREEN                             │
│                                                             │
│                    [YOUR LOGO]                              │
│                   Loading.....                              │
│                                                             │
└─────────────────────────────────────────────────────────────┘
            ↓ (after few seconds)
┌─────────────────────────────────────────────────────────────┐
│  PHASE 2: HOME SCREEN                                       │
├─────────────────────────────────────────────────────────────┤
│  📅 Date: 15/01/2025    🕐 Time: 14:30:00    🌡️ Temp: 45°C  │
│                                                             │
│                    📱 APP NAME                              │
│           "Brief description of the application"            │
│                                                             │
├─────────────────────────────────────────────────────────────┤
│                      GALLERY                                │
│   ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐       │
│   │ Product │  │ Product │  │ Product │  │ Product │       │
│   │    1    │  │    2    │  │    3    │  │    4    │       │
│   └─────────┘  └─────────┘  └─────────┘  └─────────┘       │
│         (Click any product → Show product info)             │
└─────────────────────────────────────────────────────────────┘
            ↓ (Phase 3 enhancement)
┌─────────────────────────────────────────────────────────────┐
│                      GALLERY                                │
│                                                             │
│    ◀️    ┌───────────────────────────┐    ▶️               │
│   LEFT   │                           │   RIGHT              │
│   ARROW  │      CURRENT PRODUCT      │   ARROW              │
│          │                           │                      │
│          └───────────────────────────┘                      │
│                                                             │
└─────────────────────────────────────────────────────────────┘
            + 
┌─────────────────────────────────────────────────────────────┐
│  PHASE 4: ABOUT SECTION                                     │
│                                                             │
│  App Name: My Product Gallery                               │
│  Version: 1.0                                               │
│  Developer: Your Name                                       │
│  Description: .....                                         │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## 🪜 Step-by-Step Breakdown

### **PHASE 1: Splash Screen**

| Step | Task | Concepts Needed |
|------|------|-----------------|
| 1.1 | Create main Window | `Window {}` |
| 1.2 | Add logo/image | `Image {}` |
| 1.3 | Add loading text or animation | `Text {}`, maybe animation |
| 1.4 | Use Timer to auto-hide splash after X seconds | `Timer {}` |
| 1.5 | Show/hide splash screen | `visible: true/false` |

**What you'll learn:**
- Timer usage
- Controlling visibility
- Basic animations (optional)

---

### **PHASE 2: Home Screen**

| Step | Task | Concepts Needed |
|------|------|-----------------|
| 2.1 | Create home screen layout | `Column {}`, `Row {}` |
| 2.2 | Display current Date & Time | `Timer {}`, `Qt.formatDateTime()` |
| 2.3 | Display App Name & Description | `Text {}` |
| 2.4 | Display Laptop Temperature | `Text {}` (hardcoded or external) |
| 2.5 | Create product data structure | `property var products: [...]` |
| 2.6 | Create gallery grid of images | `Row {}` or `Grid {}` + `Image {}` |
| 2.7 | Make each image clickable | `MouseArea {}` |
| 2.8 | Show product info on click | `Text {}` binding or popup |

**What you'll learn:**
- Complex layouts
- Data structures (arrays/lists)
- Property binding
- Event handling

---

### **PHASE 3: Image Navigation**

| Step | Task | Concepts Needed |
|------|------|-----------------|
| 3.1 | Create left/right arrow buttons | `Rectangle {}` + `Text {}` or `Image {}` |
| 3.2 | Track current image index | `property int currentIndex: 0` |
| 3.3 | Change image on arrow click | `MouseArea {}`, index manipulation |
| 3.4 | Handle boundaries (first/last image) | Conditional logic |

**What you'll learn:**
- State management
- Index-based navigation
- Conditional logic in QML

---

### **PHASE 4: About Section**

| Step | Task | Concepts Needed |
|------|------|-----------------|
| 4.1 | Create About section/page | `Rectangle {}` + `Column {}` |
| 4.2 | Display app info | `Text {}` |
| 4.3 | Add button to show/hide About | `MouseArea {}` or `Button {}` |

**What you'll learn:**
- Section visibility toggle
- Simple navigation between views


