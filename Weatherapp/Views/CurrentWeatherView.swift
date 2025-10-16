//
//  CurrentWeatherView.swift
//  weather_app
//
//  Created by DEEPAK JAIN on 16/10/25.
//

import SwiftUI

struct CurrentWeatherView: View {
    
    let current: Current
    let timezone: String
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(current.weather.first?.main ?? "-")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                Text(current.weather.first?.description.capitalized ?? "")
                    .foregroundColor(.white)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("\(Int(round(current.temp)))°C")
                    .font(.system(size: 44, weight: .bold))
                    .foregroundColor(.white)
                Text("Feels Like \(Int(round(current.feels_like ?? current.temp)))°C")
                    .foregroundColor(.white)
                    .font(.subheadline)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.gray.opacity(0.3))
        )
    }
}
