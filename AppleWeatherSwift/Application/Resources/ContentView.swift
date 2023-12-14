//
//  ContentView.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 01.11.2023.
//

//import SwiftUI
//
//struct ContentView: View {
//
//    @State private var selectedTab = 0
//
//    var body: some View {
//        TabView(selection: $selectedTab) {
//            TodayView()
//                .tabItem {
//                    Image(.tabBarToday)
//                        .foregroundColor(selectedTab == 0 ? .tabBar : .gray)
//                    Text("Today")
//                        .font(.tabBarFont)
//                        .background()
//                }
//                .tag(0)
//                .toolbarBackground(.mainBackground, for: .tabBar)
//            ForecastView()
//                .tabItem {
//                    Image(.tabBarForecast)
//                        .foregroundColor(selectedTab == 1 ? .tabBar : .gray)
//                    Text("Forecast")
//                        .font(.tabBarFont)
//                        .background(.tabBar)
//                }
//                .tag(1)
//                .toolbarBackground(.mainBackground, for: .tabBar)
//        }
//        .accentColor(.tabBar)
//        .onAppear {
//            selectedTab = 0
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//}

import SwiftUI
import CoreLocationUI

struct ContentView: View {
    
    var weatherManager = WeatherManager()
    
    @StateObject var locationManager = LocationManager()
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            
            if let location = locationManager.location {
                if let weather = viewModel.weather {
                    tabBarView
                } else {
                    LoadingView()
                        .task {
                            do {
                                viewModel.forecast = try await weatherManager.getForecastWeather(latitude: location.latitude, longitude: location.longitude)
                                
                                viewModel.weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            } catch {
                                print("Error getting weather: \(error)")
                            }
                        }
                }
                
            } else {
                if locationManager.isLoading {
                    LoadingView()
                } else {
                    loadingView
                }
            }
        }
    }
    
    @ViewBuilder
    var tabBarView: some View {
        TabView(selection: $viewModel.selectedTab) {
            TodayView(weather: viewModel.weather!)
                .tabItem {
                    Image(.tabBarToday)
                        .foregroundColor(viewModel.selectedTab == 0 ? .tabBar : .gray)
                    Text("Today")
                        .font(.tabBarFont)
                        .background()
                }
                .tag(0)
                .toolbarBackground(.mainBackground, for: .tabBar)
            ForecastView(forecast: viewModel.forecast)
                .tabItem {
                    Image(.tabBarForecast)
                        .foregroundColor(viewModel.selectedTab == 1 ? .tabBar : .gray)
                    Text("Forecast")
                        .font(.tabBarFont)
                        .background(.tabBar)
                }
                .tag(1)
                .toolbarBackground(.mainBackground, for: .tabBar)
        }
        .accentColor(.tabBar)
        .onAppear {
            viewModel.selectedTab = 0
        }
    }
    
    @ViewBuilder
    var loadingView: some View {
        TabView(selection: $viewModel.selectedTab) {
            EnableLocationView()
                .tabItem {
                    Image(.tabBarToday)
                    Text("Today")
                        .font(.tabBarFont)
                        .background()
                }
                .tag(0)
                .toolbarBackground(.mainBackground, for: .tabBar)
                .environmentObject(locationManager)
            EnableLocationView()
                .tabItem {
                    Image(.tabBarForecast)
                    Text("Forecast")
                        .font(.tabBarFont)
                        .background(.tabBar)
                }
                .tag(1)
                .toolbarBackground(.mainBackground, for: .tabBar)
                .environmentObject(locationManager)
        }
        .accentColor(.tabBar)
        .onAppear {
            viewModel.selectedTab = 0
        }
    }
}

#Preview {
    ContentView()
}


