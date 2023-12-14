//
//  Extension.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 04.12.2023.
//

import Foundation
import SwiftUI

// Extension for rounded Double to 0 decimals
extension Double {
    func roundDouble() -> String {
        return String(format: "%.0f", self)
    }
}

//extension Double {
//    func kelvinToCelsius() -> Double {
//        return self - 273.15
//    }
//}

extension Double {
    func metersPerSecondToKilometersPerHour() -> Double {
            return self * 3.6
        }
    }

func countryName(countryCode: String) -> String? {
        let current = Locale(identifier: "en_US")
        return current.localizedString(forRegionCode: countryCode)
    }


