//
//  WeatherViewModel.swift
//  weather_app
//
//  Created by DEEPAK JAIN on 16/10/25.
//

import Foundation
import Combine
import CoreLocation

@MainActor
final class WeatherViewModel: ObservableObject {
    
    @Published var weather: WeatherResponseModel?
    @Published var isLoading = false
    @Published var strErrorMsg: String?
    
    private let service = WeatherService()
    private var cancellabels = Set<AnyCancellable>()
    
    
    func loadWeatherData(lat: Double, lang: Double) {
        self.isLoading = true
        self.strErrorMsg = nil
        
        service.fatchWeather(lat: lat, lang: lang)
            .receive(on: DispatchQueue.main)
            .sink { compleation in
                self.isLoading = false
                
                switch compleation {
                case .finished:
                    break
                case .failure(let error):
                    switch error {
                    case .invalidURL:
                        self.strErrorMsg = "Invalid Requrst URL"
                    case .requestFailed(let message):
                        self.strErrorMsg = message.localizedDescription
                    case .decodingFailed:
                        self.strErrorMsg = "Failed to decode response"
                    default:
                        break;
                    }
                    self.strErrorMsg = error.localizedDescription
                }
            } receiveValue: { response in
                self.weather = response
            }
            .store(in: &cancellabels)

    }
}
