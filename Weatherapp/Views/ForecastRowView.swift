//
//  ForecastRowView.swift
//  weather_app
//
//  Created by DEEPAK JAIN on 16/10/25.
//

import SwiftUI
import SwiftUICore

struct ForecastRowView: View {
    let day: Daily
    
    var body: some View {
        HStack {
            Text(day.dt.toDayofWeek())
                .frame(width: 90, alignment: .leading)
                .foregroundColor(.white)
            Spacer()
            Text(day.weather.first?.main ?? "-")
                .foregroundColor(.white)
                .frame(width: 100, alignment: .center)
            Spacer()
            VStack(alignment: .trailing) {
                Text("\(Int(round(day.temp.max)))° / \(Int(round(day.temp.min)))°")
                    .foregroundColor(.white)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 6)
        
    }
}
