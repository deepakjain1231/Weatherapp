//
//  Enum.swift
//  Weatherapp
//
//  Created by DEEPAK JAIN on 16/10/25.
//

import SwiftUI

enum Error_State: String, Identifiable {
    case none
    case noInternet
    case locationNotAvailable
    case apiError
    case unknown

    var id: String { self.rawValue }

    var message: String {
        switch self {
        case .noInternet:
            return strText.strNoInternet.rawValue
        case .locationNotAvailable:
            return strText.strlocationNotAvailable.rawValue
        case .apiError:
            return strText.strApiError.rawValue
        case .unknown:
            return strText.strSomethingWentWrong.rawValue
        case .none:
            return ""
        }
    }
}
