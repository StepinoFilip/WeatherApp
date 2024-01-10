//
//  WeatherManager.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 02.12.2023.
//

import Foundation
import CoreLocation
import SwiftUI

class WeatherManager {
    
    func getImageNameForWeatherIcon(icon: String) -> String {
            switch icon {
            case "01d":
                return "ForecastSun"
            case "01n":
                return "ForecastMoon"
            case "02d":
                return "ForecastFewCloudsSun"
            case "02n":
                return "ForecastFewCloudsMoon"
            case "03d":
                return "ForecastCloudy"
            case "03n":
                return "ForecastCloudy"
            case "04d":
                return "ForecastCloudy"
            case "04n":
                return "ForecastCloudy"
            case "09d":
                return "ForecastShowersLight"
            case "09n":
                return "ForecastShowersLight"
            case "10d":
                return "ForecastRain"
            case "10n":
                return "ForecastRain"
            case "11d":
                return "ForecastThunderstorm"
            case "11n":
                return "ForecastThunderstorm"
            case "13d":
                return "ForecastSnow"
            case "13n":
                return "ForecastSnow"
            case "50d":
                return "ForecastMist"
            case "50n":
                return "ForecastMist"
            // Add more cases for other icon values as needed
            default:
                return "DefaultImage" // Provide a default image name or URL
            }
        }
    
    func getImageNameForForecastIcon(icon: String) -> String {
            switch icon {
            case "01d":
                return "ForecastSun"
            case "01n":
                return "ForecastMoon"
            case "02d":
                return "ForecastFewCloudsSun"
            case "02n":
                return "ForecastFewCloudsMoon"
            case "03d":
                return "ForecastCloudy"
            case "03n":
                return "ForecastCloudy"
            case "04d":
                return "ForecastCloudy"
            case "04n":
                return "ForecastCloudy"
            case "09d":
                return "ForecastShowersLight"
            case "09n":
                return "ForecastShowersLight"
            case "10d":
                return "ForecastRain"
            case "10n":
                return "ForecastRain"
            case "11d":
                return "ForecastThunderstorm"
            case "11n":
                return "ForecastThunderstorm"
            case "13d":
                return "ForecastSnow"
            case "13n":
                return "ForecastSnow"
            case "50d":
                return "ForecastMist"
            case "50n":
                return "ForecastMist"
            // Add more cases for other icon values as needed
            default:
                return "DefaultImage" // Provide a default image name or URL
            }
        }
    
    func getWeatherInfoFormWeatherIcon(icon: String, temperature: Double) -> String {
            switch icon {
            case "01d":
                if temperature > 30 {
                    return String(localized: "hot.message")
                } else {
                    return String(localized: "day.clear.sky.message")
                }
            case "01n":
                return String(localized: "night.clear.sky.message")
            case "02d":
                return String(localized: "few.clouds.message")
            case "02n":
                return String(localized: "few.clouds.message")
            case "03d":
                return String(localized: "cloudy.message")
            case "03n":
                return String(localized: "cloudy.message")
            case "04d":
                return String(localized: "cloudy.message")
            case "04n":
                return String(localized: "cloudy.message")
            case "09d":
                return String(localized: "showers.message")
            case "09n":
                return String(localized: "showers.message")
            case "10d":
                return String(localized: "rainy.message")
            case "10n":
                return String(localized: "rainy.message")
            case "11d":
                return String(localized: "thunderstrom.message")
            case "11n":
                return String(localized: "thunderstrom.message")
            case "13d":
                return String(localized: "snow.message")
            case "13n":
                return String(localized: "snow.message")
            case "50d":
                return String(localized: "fog.message")
            case "50n":
                return String(localized: "fog.message")
            // Add more cases for other icon values as needed
            default:
                return String(localized: "no.info.current.weather")
            }
        }
    
    func getWeatherInfoFormForecastIcon(icon: String) -> String {
            switch icon {
            case "01d":
                return String(localized: "forecast.sun.message")
            case "01n":
                return String(localized: "forecast.moon.message")
            case "02d":
                return String(localized: "forecast.scattered.clouds.message")
            case "02n":
                return String(localized: "forecast.scattered.clouds.message")
            case "03d":
                return String(localized: "forecast.cloudy.message")
            case "03n":
                return String(localized: "forecast.cloudy.message")
            case "04d":
                return String(localized: "forecast.cloudy.message")
            case "04n":
                return String(localized: "forecast.cloudy.message")
            case "09d":
                return String(localized: "forecast.rain.showers.message")
            case "09n":
                return String(localized: "forecast.rain.showers.message")
            case "10d":
                return String(localized: "forecast.rain.message")
            case "10n":
                return String(localized: "forecast.rain.message")
            case "11d":
                return String(localized: "forecast.thunderstorm.message")
            case "11n":
                return String(localized: "forecast.thunderstorm.message")
            case "13d":
                return String(localized: "forecast.snowing.message")
            case "13n":
                return String(localized: "forecast.snowing.message")
            case "50d":
                return String(localized: "forecast.mist.message")
            case "50n":
                return String(localized: "forecast.mist.message")
            // Add more cases for other icon values as needed
            default:
                return String(localized: "forecast.no.info.current.weather")
            }
        }
    
    
// MARK: - API CALLING Current Weather
    struct CurrentAPIConfig {
        static let baseURL = "https://api.openweathermap.org/data/2.5/"
        static let apiKey = "020e61171acbd0230c6f8fe970f138e7"
    }
    
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> CurrentResponse {
        guard let url = URL(string: "\(CurrentAPIConfig.baseURL)weather?lat=\(latitude)&lon=\(longitude)&appid=\(CurrentAPIConfig.apiKey)&units=metric") else { fatalError("Missing URL") }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw GHError.invalidResponse
        }
        
        let decodedData = try JSONDecoder().decode(CurrentResponse.self, from: data)
                
        return decodedData
    }
    
// MARK: - API CALLING Forecast
    struct ForecastAPIConfig {
        static let baseURL = "https://api.openweathermap.org/data/2.5/"
        static let apiKey = "020e61171acbd0230c6f8fe970f138e7"
    }
    
    func getForecastWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ForecastResponse {
        guard let url = URL(string: "\(ForecastAPIConfig.baseURL)forecast?lat=\(latitude)&lon=\(longitude)&appid=\(ForecastAPIConfig.apiKey)&units=metric") else { fatalError("Missing URL") }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
    
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw GHError.invalidResponse
        }
        
        let decoder = JSONDecoder()
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let decodedData = try decoder.decode(ForecastResponse.self, from: data)
                
        return decodedData
    }
}

enum GHError: Error {
    case invalidResponse
}

// MARK: - Model of the response body we get from calling the OpenWeather API
struct CurrentResponse: Decodable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse
    var sys: CountryName
    var rain: Precipitation?

    
    struct CoordinatesResponse: Decodable {
        var lon: Double
        var lat: Double
    }
    
    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }
    
    struct MainResponse: Decodable {
        var temp: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Decodable {
        var speed: Double
        let deg: Double
        var windDirection: String {
            if deg >= 337 || deg < 23 {
                return "N"
            }
            if deg < 67 {
                return "NE"
            }
            if deg < 113 {
                return "E"
            }
            if deg < 157 {
                return "SE"
            }
            if deg < 203 {
                return "S"
            }
            if deg < 247 {
                return "SW"
            }
            if deg < 293 {
                return "W"
            }
            return "NW"
        }
    }
    
    struct CountryName: Decodable {
        var country: String
    }
    
    struct Precipitation: Decodable {
        var oneHour: Double?
        
        enum CodingKeys: String, CodingKey {
            case oneHour = "1h"
        }
    }
}

struct ForecastResponse: Decodable {
    let city: CoordinatesResp
    let list: [ListResponse]
    
    struct ListResponse: Decodable {
        var date: Double
        var main: MainResponseForecast
        var weather: [WeatherResponseForecast]
        
        enum CodingKeys: String, CodingKey {
            case date = "dt"
            case main
            case weather
        }
    }
    
    struct CoordinatesResp: Decodable {
        var coord: Coordinates
    }
    
    struct Coordinates: Decodable {
        var lon: Double
        var lat: Double
    }
        
    struct MainResponseForecast: Decodable {
        var temp: Double
    }
    
    struct WeatherResponseForecast: Decodable {
        var icon: String
    }
}
