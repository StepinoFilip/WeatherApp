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
                    return "It’s hot as f***."
                } else {
                    return "Is sunny day, go out."
                }
            case "01n":
                return "Can see stars."
            case "02d":
                return "There’s few clouds"
            case "02n":
                return "There’s few clouds"
            case "03d":
                return "It’s cloudy"
            case "03n":
                return "Sory, no stars"
            case "04d":
                return "It’s cloudy"
            case "04n":
                return "It’s cloudy"
            case "09d":
                return "It’s showers."
            case "09n":
                return "It’s showers."
            case "10d":
                return "It’s raining."
            case "10n":
                return "It’s raining."
            case "11d":
                return "Fear the lightning."
            case "11n":
                return "Fear the lightning."
            case "13d":
                return "It’s snowing"
            case "13n":
                return "It's snowing."
            case "50d":
                return "It's foggy."
            case "50n":
                return "It's foggy."
            // Add more cases for other icon values as needed
            default:
                return "DefaultImage" // Provide a default image name or URL
            }
        }
    
    func getWeatherInfoFormForecastIcon(icon: String) -> String {
            switch icon {
            case "01d":
                return "Sunny."
            case "01n":
                return "Clean sky."
            case "02d":
                return "Scattered clouds."
            case "02n":
                return "Scattered clouds."
            case "03d":
                return "Cloudy"
            case "03n":
                return "Cloudy"
            case "04d":
                return "Cloudy"
            case "04n":
                return "Cloudy"
            case "09d":
                return "Rain showers."
            case "09n":
                return "Rain showers.."
            case "10d":
                return "Raining."
            case "10n":
                return "Raining."
            case "11d":
                return "Thunderstorm!"
            case "11n":
                return "Thunderstorm!"
            case "13d":
                return "Snowing"
            case "13n":
                return "Snowing."
            case "50d":
                return "Mist!."
            case "50n":
                return "Mist!"
            // Add more cases for other icon values as needed
            default:
                return "DefaultImage" // Provide a default image name or URL
            }
        }
    
//    class WeatherManager {
//        func getColorFromWeatherIcon(icon: String, temperature: Double) -> [Color] {
//            switch icon {
//            case "01d":
//                return [temperature > 300 ? .red : .red, orange, .mainBackground]
//            case "01n":
//                return [.rain1, .rain2, .mainBackground]
//            case "02d", "02n", "03d", "03n", "04d", "04n":
//                return [.rain1, .rain2, .mainBackground]
//            case "09d", "09n", "10d", "10n":
//                return [.rain1, .rain2, .mainBackground]
//            case "11d", "11n":
//                return [.rain1, .rain2, .mainBackground]
//            case "13d", "13n":
//                return [.rain1, .rain2, .mainBackground]
//            case "50d", "50n":
//                return [.rain1, .rain2, .mainBackground]
//            default:
//                return [.rain1, .rain2, .mainBackground]
//            }
//        }
//    }
//
//    
    
// MARK: - API CALLING Current Weather
    struct CurrentAPIConfig {
        static let baseURL = "https://api.openweathermap.org/data/2.5/"
        static let apiKey = "020e61171acbd0230c6f8fe970f138e7"
    }
    
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> CurrentResponse {
        guard let url = URL(string: "\(CurrentAPIConfig.baseURL)weather?lat=\(latitude)&lon=\(longitude)&appid=\(CurrentAPIConfig.apiKey)&units=metric") else { fatalError("Missing URL") }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
        
        let decodedData = try JSONDecoder().decode(CurrentResponse.self, from: data)
        
//        let imageName = getImageNameForWeatherIcon(icon: decodedData.weather.first?.icon ?? "")
        
//        let temperature = decodedData.main.temp
//        let weatherInfo = getWeatherInfoFormWeatherIcon(icon: decodedData.weather.first?.icon ?? "", temperature: temperature)
                
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
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
        
        let decoder = JSONDecoder()
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
//        decoder.dateDecodingStrategy = .secondsSince1970
        
        let decodedData = try decoder.decode(ForecastResponse.self, from: data)
                
        return decodedData
    }
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
