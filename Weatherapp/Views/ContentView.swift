//
//  ContentView.swift
//  weather_app
//
//  Created by DEEPAK JAIN on 16/10/25.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    
    @EnvironmentObject var locationManger: LocationManager
    @EnvironmentObject var weatherViewModel: WeatherViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient.init(colors: [Color.black, Color.blue]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                header
                if let weather = weatherViewModel.weather {
                    CurrentWeatherView(current: weather.current, timezone: weather.timezone)
                    forecastList(daily: Array(weather.daily.prefix(5)))
                }
                else if weatherViewModel.isLoading {
                    ProgressView("Fatching weather").tint(.white)
                }
                else if let error = weatherViewModel.strErrorMsg {
                    Text(error)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                else {
                    Text("Waiting for loation")
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                HStack {
                    Button(action: refresh) {
                        Label("Refresh", systemImage: "arrow.clockwise")
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                    
                    Button(action: { locationManger.requestLocation() }) {
                        Label("Locate", systemImage: "location.fill")
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                    
                }
            }
            .padding()
            
        }
        .onChange(of: locationManger.lastLocation, { oldValue, newLoc in
            if let loc = newLoc {
                weatherViewModel.loadWeatherData(lat: loc.coordinate.latitude, lang: loc.coordinate.longitude)
            }
        })
        
    }
    
    
    var header: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Forest Weather")
                    .font(.largeTitle).bold()
                    .foregroundColor(.white)
                Text(Date(), style: .date)
                    .foregroundColor(.white)
                    .font(.subheadline)
            }
             Spacer()
            
        }
    }
    
    func refresh() {
        if let loc = locationManger.lastLocation {
            weatherViewModel.loadWeatherData(lat: loc.coordinate.latitude, lang: loc.coordinate.longitude)
        }
        else {
            locationManger.requestLocation()
        }
    }
    
    func forecastList(daily: [Daily]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("5-Day Forecast")
                .foregroundColor(.white)
                .font(.headline)
            ForEach(daily) { day in
                ForecastRowView(day: day)
            }
        }
        .padding()
        .background(Color.white.opacity(0.08))
        .cornerRadius(16)
        
    }
    
    
}

#Preview {
    ContentView()
}
