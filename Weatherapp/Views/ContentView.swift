//
//  ContentView.swift
//  Weatherapp
//
//  Created by DEEPAK JAIN on 16/10/25.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    
    @EnvironmentObject var location_Manager: LocationManager
    @StateObject private var view_Model = WeatherViewModel()
    
    var body: some View {
        ZStack {
            backgroundWeatherIImage()
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top image
                Image(uiImage: getWeatherImage(for: view_Model.condition))
                    .resizable()
                    .scaledToFill()
                    .frame(height: 380)
                    .clipped()
                    .overlay(
                        VStack(spacing: -8) {
                            Text("\(view_Model.currentTemp)°")
                                .font(.AppFontSemiBold(70))
                                .foregroundColor(.white)
                            Text(view_Model.condition.uppercased())
                                .font(.AppFontMedium(28))
                                .foregroundColor(.white)
                        }
                            .offset(y: -28)
                    )
                
                // Min, Current, Max
                HStack {
                    setMinMaxCurrentSection(temp: view_Model.minTemp, label: strText.strMin.rawValue)
                    Spacer()
                    setMinMaxCurrentSection(temp: view_Model.currentTemp, label: strText.strCurrent.rawValue)
                    Spacer()
                    setMinMaxCurrentSection(temp: view_Model.maxTemp, label: strText.strMax.rawValue)
                }
                .padding(.horizontal, 30)
                .padding(.top, 8)
                
                Rectangle()
                    .fill(Color.white)
                    .frame(height: 1)
                    .padding(.horizontal, 0)
                    .padding(.top, 8)
                
                // Forecast
                VStack(spacing: 18) {
                    ForEach(view_Model.forecast) { day in
                        HStack {
                            Text(day.day)
                                .foregroundColor(.whiteDark)
                                .font(.AppFontRegular(16))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Image(uiImage: weatherIcon(for: day.condition))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                            Text("\(Int(day.avgTemp))°")
                                .foregroundColor(.whiteDark)
                                .font(.AppFontMedium(16))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                }
                .padding(.horizontal, 32)
                .padding(.top, 25)
                
                Spacer()
            }
            
            // MARK: Loading Overlay
            if view_Model.isLoading {
                ZStack {
                    Color.black.opacity(0.4).ignoresSafeArea()
                    ProgressView("")
                        .font(.headline)
                        .foregroundColor(.white)
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.4)
                }
                .transition(.opacity)
            }
        }
        .ignoresSafeArea()
        .onChange(of: location_Manager.lastLocation) { _, newLoc in
            if let loc = newLoc {
                view_Model.fetchWeather(latitude: loc.coordinate.latitude, longitude: loc.coordinate.longitude)
            }
        }
        .alert(item: Binding<Error_State?>(
            get: {
                if location_Manager.errorState != .none {
                    return location_Manager.errorState
                } else if view_Model.errorState != .none {
                    return view_Model.errorState
                } else {
                    return nil
                }
            },
            set: { _ in
                location_Manager.errorState = .none
                view_Model.errorState = .none
            }
        )) { err in
            return Alert(title: Text(strText.strErrorTitle.rawValue), message: Text(err.message), dismissButton: .default(Text(strText.strOk.rawValue)))
        }
    }
    
    // MARK: - Helper Views

    func setMinMaxCurrentSection(temp: Int, label: String) -> some View {
        VStack(spacing: -2) {
            Text("\(temp)°")
                .font(.AppFontMedium(16))
                .foregroundColor(.whiteDark)
            Text(label)
                .font(.AppFontRegular(12))
                .foregroundColor(.whiteDark)
        }
    }
    
    func weatherIcon(for condition: String) -> UIImage {
        switch condition.lowercased() {
        case "clouds": return .iconClear
        case "rain": return .iconRain
        case "clear": return .iconPartlysunny
        case "snow": return .iconRain
        default: return .iconClear
        }
    }
    
    func backgroundWeatherIImage() -> some View {
        switch view_Model.condition.lowercased() {
        case "clouds": return Color.cloudy
        case "rain": return Color.rainy
        case "clear": return Color.sunny
        default: return Color.sunny
        }
    }
    
    func getWeatherImage(for condition: String) -> UIImage {
        switch condition.lowercased() {
        case "clouds": return .forestCloudy
        case "rain": return .forestRainy
        case "clear": return .forestSunny
        default: return .forestCloudy
        }
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}

