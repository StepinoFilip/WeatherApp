//
//  TodayView-ViewModel.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 23.12.2023.
//

import Foundation

final class TodayViewModel: ObservableObject {
    @Published var shouldPresentShareSheet = false
    @Published var shouldReloaded = false
    @Published private(set) var state: State = .loading
    private(set) var locationManager = LocationManager()
    private var weatherManager = WeatherManager()
    
    private var loadingTask: Task<Void, Never>?
    
    @MainActor
    func getWeather() async {
        guard locationManager.status == .locationGranted, let location = locationManager.location else {
            state = .missingLocation
            
            return
        }
        
        state = .loading
        
        do {
            let response = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
            state = .succes(response)
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}

// MARK: - State
extension TodayViewModel {
    enum State {
        case loading
        case missingLocation
        case succes(CurrentResponse)
        case error(String)
    }
}
