# Weatherapp — SwiftUI (Forest design)

**Weatherapp** is a SwiftUI-based iOS application that provides real-time weather information and a 7-day forecast based on the user’s current location.  
It dynamically changes background visuals according to weather conditions (Sunny, Cloudy, Rainy) for a visually engaging experience.


## Features

- **Current Location Weather** — Fetches live weather data based on your device’s GPS location.  
- **7-Day Forecast** — Displays the upcoming weather forecast for your current location.  
- **Dynamic Backgrounds** — Background images change automatically to reflect weather conditions:
  - Forest – Sunny  
  - Forest – Cloudy  
  - Forest – Rainy  
- **Connectivity Checks** — Alerts when location services or No Internet Connection.
- **SwiftUI Interface** — Built entirely using SwiftUI with modern, clean UI design.

---

## API Information

Weather data is powered by the **OpenWeatherMap API**.

```swift
// API Configuration
let BaseUrl_Weather = "https://api.openweathermap.org/data/2.5/weather"
let BaseUrl_Forest  = "https://api.openweathermap.org/data/2.5/forecast"
let Quary_Params    = "?lat=%@&lon=%@&appid=%@&units=metric"
let APIKey          = "d5a8a16c6c71e4b75afd2ac5b6adde0c"
```

> **Note:** The API key provided is for development/demo purposes.  
> For production use, create new API key from [OpenWeatherMap](https://openweathermap.org/api).

---

## Build & Run Instructions

1. **Clone or Download** this repository.  
2. **Open** the project in **Xcode** (`Weatherapp.xcodeproj`).  
3. **Enable Location Access**  
   - Go to your iOS device Settings → Privacy → Location Services → Allow for Weatherapp.  
6. **Run the App** on a simulator or physical device.

---

## Requirements

- iOS 16.0 or later  
- Xcode 15 or later  
- Swift 5.9+  
- Active internet connection and location permission

---

## Architecture

- **SwiftUI** — Declarative UI framework for modern iOS apps  
- **CoreLocation** — For fetching the device’s current latitude and longitude  
- **MVVM Pattern** — Clean separation of View, Model, and ViewModel components

---

## Files
- weather_appApp.swift — App entry
- Views/ContentView.swift — main UI
- Helpers/Network.swift = networking
- Services/LocationManager.swift — CoreLocation
- ViewModels/WeatherViewModel.swift — API call
- Models/WeatherResponseModel.swift — Codable models for api response

---

## Author

**Deepak Jain**  
Senior iOS & Apple TV App Developer  

---

## License

```
MIT License

Copyright (c) 2025 Deepak Jain

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

[Standard MIT License text continues...]
```

---
