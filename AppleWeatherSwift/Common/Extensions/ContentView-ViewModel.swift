//
//  ContentView-ViewModel.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 13.12.2023.
//

import Foundation
import CoreLocationUI

extension ContentView {
   @MainActor class ViewModel: ObservableObject {
       @Published var weather: ResponseBody?
       @Published var forecast: ResponseBody?
       @Published var selectedTab = 0
       @Published private var isLocationEnabled: Bool = true
       
    }
}
