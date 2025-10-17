//
//  weather_appApp.swift
//  Weatherapp
//
//  Created by DEEPAK JAIN on 16/10/25.
//

import SwiftUI

@main
struct weather_appApp: App {
    
    @StateObject private var locationManage = LocationManager()
    @StateObject private var weatherViewModel = WeatherViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(locationManage)
                .environmentObject(weatherViewModel)
                .onAppear() {
                    locationManage.requestLocation()
                }
            
            
        }
    }
}
