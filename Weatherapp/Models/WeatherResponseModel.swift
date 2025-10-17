//
//  WeatherResponseModel.swift
//  Weatherapp
//
//  Created by DEEPAK JAIN on 16/10/25.
//

import Foundation

struct CurrentWeatherResponse: Codable {
    let main: MainClass
    let weather: [Weather]
}

struct WeatherResponseModel: Codable {
    let list: [ForecastItem]
    let city: City
}

struct City: Codable {
    let name: String
    let country: String
}

struct ForecastItem: Codable, Identifiable {
    let id = UUID()
    let dt: Int
    let main: MainClass
    let weather: [Weather]
}

struct MainClass: Codable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
}

struct Weather: Codable {
    let main: String
    let description: String
    let icon: String
}

// MARK: - Daily Forecast Model
struct DailyForecast: Identifiable {
    let id = UUID()
    let day: String
    let condition: String
    let avgTemp: Double
}
