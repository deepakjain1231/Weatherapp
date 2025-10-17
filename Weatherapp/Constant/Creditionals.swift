//
//  Creditionals.swift
//  Weatherapp
//
//  Created by DEEPAK JAIN on 16/10/25.
//

import SwiftUI

//MARK: - WEATHER API KEY
let APIKey = "d5a8a16c6c71e4b75afd2ac5b6adde0c"

//MARK: - API URLS 
struct API {
    let BaseUrl_Weather = "https://api.openweathermap.org/data/2.5/weather"
    let BaseUrl_Forest = "https://api.openweathermap.org/data/2.5/forecast"
    let Quary_Params = "?lat=%@&lon=%@&appid=%@&units=metric"

    var str_WeatherURL: String {
        BaseUrl_Weather + Quary_Params
    }

    var str_ForecastURL: String {
        BaseUrl_Forest + Quary_Params
    }
}
