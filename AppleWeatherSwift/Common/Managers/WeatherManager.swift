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
                return "TodayCloudy"
            case "04n":
                return "TodayCloudy"
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
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=020e61171acbd0230c6f8fe970f138e7&units=metric") else { fatalError("Missing URL") }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
        
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        
//        let imageName = getImageNameForWeatherIcon(icon: decodedData.weather.first?.icon ?? "")
        
        let temperature = decodedData.main.temp
//        let weatherInfo = getWeatherInfoFormWeatherIcon(icon: decodedData.weather.first?.icon ?? "", temperature: temperature)
                
        return decodedData
    }
    
// MARK: - API CALLING Forecast
    func getForecastWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=020e61171acbd0230c6f8fe970f138e7&units=metric") else { fatalError("Missing URL") }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
        }
        
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
                
        return decodedData
    }
}

// MARK: - API DATA

//curl -X GET "https://api.openweathermap.org/data/2.5/weather?lat=50.0755&lon=14.4378&appid=020e61171acbd0230c6f8fe970f138e7"
//{"coord":{"lon":14.438,"lat":50.076},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"base":"stations","main":{"temp":268.56,"feels_like":264.61,"temp_min":266.88,"temp_max":270.32,"pressure":1010,"humidity":92},"visibility":10000,"wind":{"speed":2.57,"deg":170},"clouds":{"all":0},"dt":1701758820,"sys":{"type":1,"id":6835,"country":"CZ","sunrise":1701758640,"sunset":1701788502},"timezone":3600,"id":3061412,"name":"Žižkov","cod":200}%
//


// MARK: - Model of the response body we get from calling the OpenWeather API
struct ResponseBody: Decodable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse
    var sys: CountryName
    var rain: Precipitation?
    var list: [ListResponse]
    
    struct ListResponse: Decodable {
        var dttxt: Double
        var main: MainResponseForecast
        var weather: [WeatherResponseForecast]
    }
    
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
    
    struct MainResponseForecast: Decodable {
        var temp: Double
        var dttxt: Double
    }
    
    struct WeatherResponseForecast: Decodable {
        var icon: String
    }
}

// MARK: - API DATA Forecast

//{
//    "cod":"200","message":0,"cnt":40,"list":[{"dt":1702371600,"main":{"temp":279.14,"feels_like":276.2,"temp_min":279.14,"temp_max":280.13,"pressure":1009,"sea_level":1009,"grnd_level":980,"humidity":88,"temp_kf":-0.99},"weather":[{"id":801,"main":"Clouds","description":"few clouds","icon":"02d"}],"clouds":{"all":18},"wind":{"speed":4.04,"deg":244,"gust":9.28},"visibility":10000,"pop":0.02,"sys":{"pod":"d"},"dt_txt":"2023-12-12 09:00:00"},{"dt":1702382400,"main":{"temp":280.51,"feels_like":277.87,"temp_min":280.51,"temp_max":281.44,"pressure":1009,"sea_level":1009,"grnd_level":979,"humidity":78,"temp_kf":-0.93},"weather":[{"id":801,"main":"Clouds","description":"few clouds","icon":"02d"}],"clouds":{"all":19},"wind":{"speed":4.07,"deg":245,"gust":6.5},"visibility":10000,"pop":0,"sys":{"pod":"d"},"dt_txt":"2023-12-12 12:00:00"},{"dt":1702393200,"main":{"temp":279.78,"feels_like":279.78,"temp_min":279.78,"temp_max":279.78,"pressure":1008,"sea_level":1008,"grnd_level":977,"humidity":81,"temp_kf":0},"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03d"}],"clouds":{"all":50},"wind":{"speed":1.28,"deg":164,"gust":1.23},"visibility":10000,"pop":0,"sys":{"pod":"d"},"dt_txt":"2023-12-12 15:00:00"},{"dt":1702404000,"main":{"temp":279.62,"feels_like":278.29,"temp_min":279.62,"temp_max":279.62,"pressure":1007,"sea_level":1007,"grnd_level":976,"humidity":85,"temp_kf":0},"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10n"}],"clouds":{"all":73},"wind":{"speed":1.94,"deg":160,"gust":3.8},"visibility":10000,"pop":0.36,"rain":{"3h":0.16},"sys":{"pod":"n"},"dt_txt":"2023-12-12 18:00:00"},{"dt":1702414800,"main":{"temp":279.3,"feels_like":277.61,"temp_min":279.3,"temp_max":279.3,"pressure":1005,"sea_level":1005,"grnd_level":974,"humidity":93,"temp_kf":0},"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10n"}],"clouds":{"all":100},"wind":{"speed":2.27,"deg":159,"gust":7.73},"visibility":10000,"pop":0.8,"rain":{"3h":2.12},"sys":{"pod":"n"},"dt_txt":"2023-12-12 21:00:00"},{"dt":1702425600,"main":{"temp":279.51,"feels_like":277.74,"temp_min":279.51,"temp_max":279.51,"pressure":1003,"sea_level":1003,"grnd_level":972,"humidity":92,"temp_kf":0},"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10n"}],"clouds":{"all":100},"wind":{"speed":2.4,"deg":179,"gust":6.21},"visibility":10000,"pop":1,"rain":{"3h":0.96},"sys":{"pod":"n"},"dt_txt":"2023-12-13 00:00:00"},{"dt":1702436400,"main":{"temp":279.28,"feels_like":277.66,"temp_min":279.28,"temp_max":279.28,"pressure":1002,"sea_level":1002,"grnd_level":971,"humidity":94,"temp_kf":0},"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10n"}],"clouds":{"all":100},"wind":{"speed":2.18,"deg":194,"gust":4.66},"visibility":10000,"pop":0.53,"rain":{"3h":0.13},"sys":{"pod":"n"},"dt_txt":"2023-12-13 03:00:00"},{"dt":1702447200,"main":{"temp":279.54,"feels_like":277.92,"temp_min":279.54,"temp_max":279.54,"pressure":1001,"sea_level":1001,"grnd_level":970,"humidity":96,"temp_kf":0},"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10n"}],"clouds":{"all":100},"wind":{"speed":2.23,"deg":212,"gust":5.31},"visibility":10000,"pop":1,"rain":{"3h":2.52},"sys":{"pod":"n"},"dt_txt":"2023-12-13 06:00:00"},{"dt":1702458000,"main":{"temp":280.39,"feels_like":278.74,"temp_min":280.39,"temp_max":280.39,"pressure":1001,"sea_level":1001,"grnd_level":970,"humidity":89,"temp_kf":0},"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10d"}],"clouds":{"all":100},"wind":{"speed":2.45,"deg":263,"gust":7.84},"visibility":10000,"pop":0.52,"rain":{"3h":0.25},"sys":{"pod":"d"},"dt_txt":"2023-12-13 09:00:00"},{"dt":1702468800,"main":{"temp":281.54,"feels_like":279.5,"temp_min":281.54,"temp_max":281.54,"pressure":1001,"sea_level":1001,"grnd_level":971,"humidity":78,"temp_kf":0},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"clouds":{"all":100},"wind":{"speed":3.39,"deg":291,"gust":6.61},"visibility":10000,"pop":0.44,"sys":{"pod":"d"},"dt_txt":"2023-12-13 12:00:00"},{"dt":1702479600,"main":{"temp":280.33,"feels_like":278.93,"temp_min":280.33,"temp_max":280.33,"pressure":1002,"sea_level":1002,"grnd_level":971,"humidity":85,"temp_kf":0},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"clouds":{"all":100},"wind":{"speed":2.14,"deg":277,"gust":4.27},"visibility":10000,"pop":0,"sys":{"pod":"d"},"dt_txt":"2023-12-13 15:00:00"},{"dt":1702490400,"main":{"temp":279.15,"feels_like":278.19,"temp_min":279.15,"temp_max":279.15,"pressure":1003,"sea_level":1003,"grnd_level":972,"humidity":87,"temp_kf":0},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"clouds":{"all":100},"wind":{"speed":1.54,"deg":277,"gust":1.58},"visibility":10000,"pop":0,"sys":{"pod":"n"},"dt_txt":"2023-12-13 18:00:00"},{"dt":1702501200,"main":{"temp":278.78,"feels_like":277.73,"temp_min":278.78,"temp_max":278.78,"pressure":1004,"sea_level":1004,"grnd_level":973,"humidity":87,"temp_kf":0},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"clouds":{"all":99},"wind":{"speed":1.57,"deg":270,"gust":1.8},"visibility":10000,"pop":0,"sys":{"pod":"n"},"dt_txt":"2023-12-13 21:00:00"},{"dt":1702512000,"main":{"temp":278.45,"feels_like":276.88,"temp_min":278.45,"temp_max":278.45,"pressure":1005,"sea_level":1005,"grnd_level":975,"humidity":88,"temp_kf":0},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"clouds":{"all":97},"wind":{"speed":1.99,"deg":280,"gust":3.62},"visibility":10000,"pop":0,"sys":{"pod":"n"},"dt_txt":"2023-12-14 00:00:00"},{"dt":1702522800,"main":{"temp":277.86,"feels_like":276.14,"temp_min":277.86,"temp_max":277.86,"pressure":1007,"sea_level":1007,"grnd_level":976,"humidity":89,"temp_kf":0},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"clouds":{"all":100},"wind":{"speed":2.04,"deg":288,"gust":3.54},"visibility":10000,"pop":0,"sys":{"pod":"n"},"dt_txt":"2023-12-14 03:00:00"},{"dt":1702533600,"main":{"temp":277.99,"feels_like":276.37,"temp_min":277.99,"temp_max":277.99,"pressure":1010,"sea_level":1010,"grnd_level":979,"humidity":88,"temp_kf":0},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"clouds":{"all":98},"wind":{"speed":1.96,"deg":313,"gust":4.96},"visibility":10000,"pop":0,"sys":{"pod":"n"},"dt_txt":"2023-12-14 06:00:00"},{"dt":1702544400,"main":{"temp":277.56,"feels_like":275.73,"temp_min":277.56,"temp_max":277.56,"pressure":1013,"sea_level":1013,"grnd_level":982,"humidity":93,"temp_kf":0},"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10d"}],"clouds":{"all":96},"wind":{"speed":2.1,"deg":346,"gust":4.52},"visibility":10000,"pop":0.54,"rain":{"3h":0.8},"sys":{"pod":"d"},"dt_txt":"2023-12-14 09:00:00"},{"dt":1702555200,"main":{"temp":277.29,"feels_like":274.67,"temp_min":277.29,"temp_max":277.29,"pressure":1015,"sea_level":1015,"grnd_level":984,"humidity":91,"temp_kf":0},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"clouds":{"all":98},"wind":{"speed":2.94,"deg":340,"gust":5.26},"visibility":8603,"pop":0.47,"sys":{"pod":"d"},"dt_txt":"2023-12-14 12:00:00"},{"dt":1702566000,"main":{"temp":277.17,"feels_like":275.05,"temp_min":277.17,"temp_max":277.17,"pressure":1018,"sea_level":1018,"grnd_level":987,"humidity":88,"temp_kf":0},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"clouds":{"all":100},"wind":{"speed":2.33,"deg":354,"gust":4.97},"visibility":10000,"pop":0.06,"sys":{"pod":"d"},"dt_txt":"2023-12-14 15:00:00"},{"dt":1702576800,"main":{"temp":276.73,"feels_like":276.73,"temp_min":276.73,"temp_max":276.73,"pressure":1021,"sea_level":1021,"grnd_level":989,"humidity":88,"temp_kf":0},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"clouds":{"all":99},"wind":{"speed":1.26,"deg":4,"gust":2.41},"visibility":10000,"pop":0.01,"sys":{"pod":"n"},"dt_txt":"2023-12-14 18:00:00"},{"dt":1702587600,"main":{"temp":276.85,"feels_like":276.85,"temp_min":276.85,"temp_max":276.85,"pressure":1023,"sea_level":1023,"grnd_level":991,"humidity":88,"temp_kf":0},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"clouds":{"all":100},"wind":{"speed":1.12,"deg":333,"gust":2.8},"visibility":10000,"pop":0.22,"sys":{"pod":"n"},"dt_txt":"2023-12-14 21:00:00"},{"dt":1702598400,"main":{"temp":277.07,"feels_like":274.79,"temp_min":277.07,"temp_max":277.07,"pressure":1025,"sea_level":1025,"grnd_level":993,"humidity":86,"temp_kf":0},"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10n"}],"clouds":{"all":100},"wind":{"speed":2.48,"deg":335,"gust":4.79},"visibility":10000,"pop":0.39,"rain":{"3h":0.15},"sys":{"pod":"n"},"dt_txt":"2023-12-15 00:00:00"},{"dt":1702609200,"main":{"temp":276.53,"feels_like":274.93,"temp_min":276.53,"temp_max":276.53,"pressure":1027,"sea_level":1027,"grnd_level":995,"humidity":87,"temp_kf":0},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"clouds":{"all":99},"wind":{"speed":1.74,"deg":345,"gust":3.99},"visibility":10000,"pop":0.04,"sys":{"pod":"n"},"dt_txt":"2023-12-15 03:00:00"},{"dt":1702620000,"main":{"temp":276.32,"feels_like":274.14,"temp_min":276.32,"temp_max":276.32,"pressure":1029,"sea_level":1029,"grnd_level":997,"humidity":91,"temp_kf":0},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"clouds":{"all":100},"wind":{"speed":2.23,"deg":327,"gust":5.89},"visibility":10000,"pop":0.01,"sys":{"pod":"n"},"dt_txt":"2023-12-15 06:00:00"},{"dt":1702630800,"main":{"temp":276.07,"feels_like":273.07,"temp_min":276.07,"temp_max":276.07,"pressure":1032,"sea_level":1032,"grnd_level":1000,"humidity":95,"temp_kf":0},"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10d"}],"clouds":{"all":99},"wind":{"speed":3.11,"deg":306,"gust":6.1},"visibility":1303,"pop":0.23,"rain":{"3h":0.15},"sys":{"pod":"d"},"dt_txt":"2023-12-15 09:00:00"},{"dt":1702641600,"main":{"temp":277.15,"feels_like":273.7,"temp_min":277.15,"temp_max":277.15,"pressure":1033,"sea_level":1033,"grnd_level":1001,"humidity":73,"temp_kf":0},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13d"}],"clouds":{"all":98},"wind":{"speed":4.13,"deg":313,"gust":7.14},"visibility":10000,"pop":0.37,"snow":{"3h":0.13},"sys":{"pod":"d"},"dt_txt":"2023-12-15 12:00:00"},{"dt":1702652400,"main":{"temp":276.45,"feels_like":273.7,"temp_min":276.45,"temp_max":276.45,"pressure":1034,"sea_level":1034,"grnd_level":1002,"humidity":79,"temp_kf":0},"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"clouds":{"all":66},"wind":{"speed":2.89,"deg":259,"gust":5.83},"visibility":10000,"pop":0.07,"sys":{"pod":"d"},"dt_txt":"2023-12-15 15:00:00"},{"dt":1702663200,"main":{"temp":277.57,"feels_like":273.65,"temp_min":277.57,"temp_max":277.57,"pressure":1036,"sea_level":1036,"grnd_level":1004,"humidity":81,"temp_kf":0},"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04n"}],"clouds":{"all":73},"wind":{"speed":5.23,"deg":280,"gust":10.35},"visibility":10000,"pop":0.08,"sys":{"pod":"n"},"dt_txt":"2023-12-15 18:00:00"},{"dt":1702674000,"main":{"temp":277.71,"feels_like":273.8,"temp_min":277.71,"temp_max":277.71,"pressure":1037,"sea_level":1037,"grnd_level":1005,"humidity":84,"temp_kf":0},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"clouds":{"all":100},"wind":{"speed":5.29,"deg":283,"gust":9.58},"visibility":10000,"pop":0.02,"sys":{"pod":"n"},"dt_txt":"2023-12-15 21:00:00"},{"dt":1702684800,"main":{"temp":276.59,"feels_like":272.82,"temp_min":276.59,"temp_max":276.59,"pressure":1038,"sea_level":1038,"grnd_level":1006,"humidity":86,"temp_kf":0},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"clouds":{"all":88},"wind":{"speed":4.46,"deg":272,"gust":9.95},"visibility":10000,"pop":0.02,"sys":{"pod":"n"},"dt_txt":"2023-12-16 00:00:00"},{"dt":1702695600,"main":{"temp":275.97,"feels_like":272.05,"temp_min":275.97,"temp_max":275.97,"pressure":1039,"sea_level":1039,"grnd_level":1007,"humidity":89,"temp_kf":0},"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03n"}],"clouds":{"all":46},"wind":{"speed":4.47,"deg":273,"gust":9.79},"visibility":10000,"pop":0,"sys":{"pod":"n"},"dt_txt":"2023-12-16 03:00:00"},{"dt":1702706400,"main":{"temp":276.36,"feels_like":273.1,"temp_min":276.36,"temp_max":276.36,"pressure":1040,"sea_level":1040,"grnd_level":1008,"humidity":86,"temp_kf":0},"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04n"}],"clouds":{"all":71},"wind":{"speed":3.55,"deg":263,"gust":8.49},"visibility":10000,"pop":0,"sys":{"pod":"n"},"dt_txt":"2023-12-16 06:00:00"},{"dt":1702717200,"main":{"temp":277.2,"feels_like":273.51,"temp_min":277.2,"temp_max":277.2,"pressure":1040,"sea_level":1040,"grnd_level":1008,"humidity":77,"temp_kf":0},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"clouds":{"all":87},"wind":{"speed":4.58,"deg":247,"gust":9.94},"visibility":10000,"pop":0,"sys":{"pod":"d"},"dt_txt":"2023-12-16 09:00:00"},{"dt":1702728000,"main":{"temp":278.95,"feels_like":275.2,"temp_min":278.95,"temp_max":278.95,"pressure":1038,"sea_level":1038,"grnd_level":1006,"humidity":71,"temp_kf":0},"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"clouds":{"all":83},"wind":{"speed":5.66,"deg":257,"gust":9.74},"visibility":10000,"pop":0,"sys":{"pod":"d"},"dt_txt":"2023-12-16 12:00:00"},{"dt":1702738800,"main":{"temp":278.29,"feels_like":274.2,"temp_min":278.29,"temp_max":278.29,"pressure":1037,"sea_level":1037,"grnd_level":1005,"humidity":76,"temp_kf":0},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"clouds":{"all":100},"wind":{"speed":6.05,"deg":253,"gust":11.9},"visibility":10000,"pop":0.02,"sys":{"pod":"d"},"dt_txt":"2023-12-16 15:00:00"},{"dt":1702749600,"main":{"temp":278.41,"feels_like":274.26,"temp_min":278.41,"temp_max":278.41,"pressure":1036,"sea_level":1036,"grnd_level":1005,"humidity":75,"temp_kf":0},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"clouds":{"all":100},"wind":{"speed":6.3,"deg":257,"gust":12.41},"visibility":10000,"pop":0.01,"sys":{"pod":"n"},"dt_txt":"2023-12-16 18:00:00"},{"dt":1702760400,"main":{"temp":278.18,"feels_like":273.94,"temp_min":278.18,"temp_max":278.18,"pressure":1036,"sea_level":1036,"grnd_level":1004,"humidity":79,"temp_kf":0},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"clouds":{"all":100},"wind":{"speed":6.35,"deg":249,"gust":13.21},"visibility":10000,"pop":0,"sys":{"pod":"n"},"dt_txt":"2023-12-16 21:00:00"},{"dt":1702771200,"main":{"temp":278.56,"feels_like":274.29,"temp_min":278.56,"temp_max":278.56,"pressure":1035,"sea_level":1035,"grnd_level":1003,"humidity":82,"temp_kf":0},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"clouds":{"all":100},"wind":{"speed":6.71,"deg":257,"gust":13.18},"visibility":10000,"pop":0,"sys":{"pod":"n"},"dt_txt":"2023-12-17 00:00:00"},{"dt":1702782000,"main":{"temp":278.57,"feels_like":274.14,"temp_min":278.57,"temp_max":278.57,"pressure":1033,"sea_level":1033,"grnd_level":1001,"humidity":85,"temp_kf":0},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"clouds":{"all":99},"wind":{"speed":7.19,"deg":251,"gust":14.14},"visibility":10000,"pop":0,"sys":{"pod":"n"},"dt_txt":"2023-12-17 03:00:00"},{"dt":1702792800,"main":{"temp":279.49,"feels_like":275,"temp_min":279.49,"temp_max":279.49,"pressure":1031,"sea_level":1031,"grnd_level":1000,"humidity":84,"temp_kf":0},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"clouds":{"all":99},"wind":{"speed":8.22,"deg":251,"gust":16.66},"visibility":10000,"pop":0,"sys":{"pod":"n"},"dt_txt":"2023-12-17 06:00:00"}],"city":{"id":3061412,"name":"Žižkov","coord":{"lat":50.0755,"lon":14.4378},"country":"CZ","population":2000,"timezone":3600,"sunrise":1702363898,"sunset":1702393206}}
//
//    
