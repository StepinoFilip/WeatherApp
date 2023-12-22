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

//extension Date {
//    static func formatUnixTimestampInGMT(_ timestamp: Double) -> String {
//        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
//        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "HH:mm a"
//        dateFormatter.timeZone = TimeZone(identifier: "GMT")
//        
//        return dateFormatter.string(from: date)
//    }
//}

extension Date {
    static func formatUnixTimestampInGMT(_ timestamp: Double) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none
        
        return dateFormatter.string(from: date)
    }
}

extension Double {
    func kelvinToCelsius() -> Double {
        return self - 273.15
    }
}

extension Date {
    func adjusting(byHours hours: TimeInterval) -> Date {
        return addingTimeInterval(3600 * hours)
    }
}
