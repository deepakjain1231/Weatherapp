//
//  Extension.swift
//  Weatherapp
//
//  Created by DEEPAK JAIN on 16/10/25.
//

import UIKit
import SwiftUICore

extension Font {
    
    static func AppFontRegular(_ fontSize: CGFloat) -> Font {
        return Font.custom("Poppins-Regular", size: fontSize)
    }
    
    static func AppFontMedium(_ fontSize: CGFloat) -> Font {
        return Font.custom("Poppins-Medium", size: fontSize)
    }
    
    static func AppFontBold(_ fontSize: CGFloat) -> Font {
        return Font.custom("Poppins-Bold", size: fontSize)
    }
    
    static func AppFontSemiBold(_ fontSize: CGFloat) -> Font {
        return Font.custom("Poppins-SemiBold", size: fontSize)
    }
    
    static func AppFontLight(_ fontSize: CGFloat) -> Font {
        return Font.custom("Poppins-Light", size: fontSize)
    }
}
