//
//  ErrorFetchingDataViewModel.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 09.01.2024.
//

//import Foundation
//
//final class ErrorFetchingDataViewModel: ObservableObject {
//    @Published var shouldPresentShareSheet = false
//    @Published var shouldReloaded = false
//    @Published private(set) var state: State = .loading
//    private(set) var locationManager = LocationManager()
//    private var weatherManager = WeatherManager()
//    
//    private var loadingTask: Task<Void, Never>?
//    
//    @MainActor
//    func getWeather() async {
//        guard locationManager.status == .locationGranted, let location = locationManager.location else {
//            state = .missingLocation
//            
//            return
//        }
//        
//        do {
//            let responseToday = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
//            state = .succesToday(responseToday)
//            let responseForecast = try await weatherManager.getForecastWeather(latitude: location.latitude, longitude: location.longitude)
//            state = .succesForecast(responseForecast)
//        } catch {
//            state = .error(error.localizedDescription)
//        }
//    }
//}
//
//// MARK: - State
//extension ErrorFetchingDataViewModel {
//    enum State {
//        case loading
//        case missingLocation
//        case succesToday(CurrentResponse)
//        case succesForecast(ForecastResponse)
//        case error(String)
//    }
//}
