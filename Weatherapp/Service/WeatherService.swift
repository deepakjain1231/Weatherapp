//
//  WeatherService.swift
//  weather_app
//
//  Created by DEEPAK JAIN on 16/10/25.
//

import Foundation
import Combine


final class WeatherService {
    
    let APIKey = "d5a8a16c6c71e4b75afd2ac5b6adde0c"
    let APIurl = "https://api.openweathermap.org/data/2.5/forecast?lat=%@&lon=%@&appid=%@"
    let session = URLSession.shared
    
    func fatchWeather(lat: Double, lang: Double) -> AnyPublisher<WeatherResponseModel, WeatherError> {
     
        let strURL = String(format: APIurl, "\(lat)", "\(lang)", APIKey)
        
        let urlRequest = URLComponents(string: strURL)
        
        guard let url = urlRequest?.url else {
            return Fail(error: WeatherError.invalidURL).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: url)
            .mapError { WeatherError.requestFailed($0) }
            .map { $0.data }
            .decode(type: WeatherResponseModel.self, decoder: JSONDecoder())
            .mapError { WeatherError.decodingFailed($0) }
            .eraseToAnyPublisher()
    }
    
}






enum WeatherError: Error {
    case invalidURL
    case requestFailed(Error)
    case decodingFailed(Error)
    case noData
    case urlSessionFailed
}
