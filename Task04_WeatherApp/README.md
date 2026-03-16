
# Weather App 🌤️

A desktop weather application built with **Qt/QML** and **C++**


[![Watch Demo Video](https://img.shields.io/badge/▶_Watch_Demo-Google_Drive-4285F4?style=for-the-badge&logo=googledrive&logoColor=white)](https://drive.google.com/file/d/1tRMJImoFUy66XIlFLoo9IJ9xv03VQMzt/view?usp=drive_link)

> **[Click here to watch the full demo video on Google Drive](https://drive.google.com/file/d/1tRMJImoFUy66XIlFLoo9IJ9xv03VQMzt/view?usp=drive_link)**

## Features
- 🔍 Search any city in the world
- 🌡️ Real-time temperature
- 💨 Wind speed
- 💧 Humidity
- 🎨 Dark glass UI design

## Tech Stack
| Part       | Technology              |
|------------|-------------------------|
| UI         | QML                     |
| Backend    | C++                     |
| Networking | Qt Network Module       |
| Data       | OpenWeatherMap API      |

## How it works
```
User searches city
      ↓
C++ sends request to OpenWeatherMap API
      ↓
JSON response parsed
      ↓
QML updates automatically via signals
```

## Project Structure
```
WeatherApp/
├── main.cpp              → App entry point
├── Main.qml              → UI
├── WeatherManager.h      → Class definition
└── WeatherManager.cpp    → API logic
```

## Setup
1. Clone the repo
2. Get free API key from [openweathermap.org](https://openweathermap.org)
3. Add your key in `WeatherManager.h`
```cpp
const QString API_KEY = "your_key_here";
```
4. Open in Qt Creator and Run!

## What I learned
- QML/C++ communication using `Q_PROPERTY` and signals
- HTTP requests with `QNetworkAccessManager`
- JSON parsing with `QJsonDocument`
- Glass morphism UI design in QML
```

