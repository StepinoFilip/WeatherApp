//
//  ModelData.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 03.12.2023.
//

import Foundation

// If you wish to Archive this project, move this file outside of the Preview Content folder, as this folder is not taken into consideration by the Xcode Archive

var previewWeather: CurrentResponse = load("weatherData.json")
var previewForecast: ForecastResponse = load("weatherDataForecast.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
