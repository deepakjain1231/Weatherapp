//
//  WeatherViewModel.swift
//  Weatherapp
//
//  Created by DEEPAK JAIN on 16/10/25.
//

import Foundation
import CoreLocation
import SwiftUICore


@MainActor
class WeatherViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var currentTemp: Int = 0
    @Published var minTemp: Int = 0
    @Published var maxTemp: Int = 0
    @Published var condition: String = "—"
    @Published var forecast: [DailyForecast] = []
    
    @Published var errorState: Error_State = .none
    @ObservedObject private var network = Network.shared
    
    
    // MARK: - Fetch Current Weather
    
    func callAPIforGetCurrentWeather(lat: Double, lang: Double) {
        guard errorState != .noInternet else { return }
        
        let urlString = String(format: API().str_WeatherURL, "\(lat)", "\(lang)", APIKey)
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let _ = error {
                DispatchQueue.main.async { self.errorState = .apiError }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async { self.errorState = .apiError }
                return
            }
            
            do {
                let response = try JSONDecoder().decode(CurrentWeatherResponse.self, from: data)
                print(response)
                DispatchQueue.main.async {
                    self.currentTemp = Int(response.main.temp.rounded())
                    self.minTemp = Int(response.main.temp_min.rounded())
                    self.maxTemp = Int(response.main.temp_max.rounded())
                    self.condition = response.weather.first?.main ?? "—"
                }
            } catch {
                print("Current weather decoding error:", error)
                DispatchQueue.main.async { self.errorState = .unknown }
            }
        }.resume()
    }
    
    
    
    // MARK: - Fetch Forecast
    func callAPIforGetForecastWeather(lat: Double, lang: Double) {
        guard errorState != .noInternet else { return }
        
        let urlString = String(format: API().str_ForecastURL, "\(lat)", "\(lang)", APIKey)
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            if let _ = error {
                DispatchQueue.main.async { self.errorState = .apiError }
                return
            }
                    
            guard let data = data else {
                DispatchQueue.main.async { self.errorState = .apiError }
                return
            }

            do {
                let response = try JSONDecoder().decode(WeatherResponseModel.self, from: data)
                print(response)
                // Group forecast items by day
                let grouped = Dictionary(grouping: response.list) { item -> String in
                    let date = Date(timeIntervalSince1970: TimeInterval(item.dt))
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    return formatter.string(from: date)
                }

                var days: [DailyForecast] = []

                for (dateString, items) in grouped.sorted(by: { $0.key < $1.key }) {
                    let avgTemp = items.map { $0.main.temp }.reduce(0, +) / Double(items.count)
                    let condition = items.first?.weather.first?.main ?? "Clear"
                    
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    if let date = formatter.date(from: dateString) {
                        let weekdayFormatter = DateFormatter()
                        weekdayFormatter.dateFormat = "EEEE"
                        let dayName = weekdayFormatter.string(from: date)
                        days.append(DailyForecast(day: dayName, condition: condition, avgTemp: avgTemp))
                    }
                }
                DispatchQueue.main.async {
                    self.forecast = Array(days.prefix(7))
                }
            } catch {
                print("Forecast decoding error:", error)
                DispatchQueue.main.async { self.errorState = .unknown }
            }
        }.resume()
    }
    
    // MARK: - API CALL BOTH
    func fetchWeather(latitude: Double, longitude: Double) {
        if network.isConnectedToNetwork {
            callAPIforGetCurrentWeather(lat: latitude, lang: longitude)
            callAPIforGetForecastWeather(lat: latitude, lang: longitude)
        }
        else {
            self.errorState = .noInternet
        }
        
    }
}


