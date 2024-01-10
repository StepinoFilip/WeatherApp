//
//  ForecastViewModel.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 08.01.2024.
//

import Foundation

final class ForecastViewModel: ObservableObject {
    @Published private(set) var state: State = .loading
    @Published var shouldReloaded = false
    private(set) var locationManager = LocationManager()
    private var weatherManager = WeatherManager()
    
    private var loadingTask: Task<Void, Never>?
    
    @MainActor
    func getForecast() async {
        guard locationManager.status == .locationGranted, let location = locationManager.location else {
            state = .missingLocation
            
            return
        }
        
        do {
            let response = try await weatherManager.getForecastWeather(latitude: location.latitude, longitude: location.longitude)
            state = .succes(response)
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}

// MARK: - State
extension ForecastViewModel {
    enum State {
        case loading
        case missingLocation
        case succes(ForecastResponse)
        case error(String)
    }
}
