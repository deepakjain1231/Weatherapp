//
//  WeatherResponseModel.swift
//  weather_app
//
//  Created by DEEPAK JAIN on 16/10/25.
//

import Foundation

struct WeatherResponseModel: Codable {
    let lat: Double
    let longi: Double
    let timezone: String
    let current: Current
    let daily: [Daily]
}

struct Current: Codable {
    let dt: TimeInterval
    let sunrise: TimeInterval?
    let sunset: TimeInterval?
    let temp: Double
    let feels_like: Double?
    let humidity: Int?
    let weather: [Weather]
}

struct Daily: Codable, Identifiable {
    var id: TimeInterval { dt }
    let dt: TimeInterval
    let sunrise: TimeInterval?
    let sunset: TimeInterval?
    let temp: Temp
    let weather: [Weather]
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Temp: Codable {
    let day: Double
    let min: Double
    let max: Double
}
