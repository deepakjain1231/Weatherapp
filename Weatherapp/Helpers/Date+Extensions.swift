//
//  Date+Extensions.swift
//  weather_app
//
//  Created by DEEPAK JAIN on 16/10/25.
//

import Foundation

extension TimeInterval {
    
    func toDate() -> Date {
        return Date(timeIntervalSince1970: self)
    }
}


extension TimeInterval {
    //Get date of week
    func toDayofWeek() -> String {
        let date = Date(timeIntervalSince1970: self)
        var dateformatter = DateFormatter()
        dateformatter.dateFormat = "EEE, MMM d"
        return dateformatter.string(from: date)
    }
}
