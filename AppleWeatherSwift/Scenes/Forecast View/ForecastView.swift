//
//  ForecastView.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 01.11.2023.
//

import SwiftUI

struct ForecastView: View {
    
    @StateObject private var viewModelForecast = ForecastViewModel()
    
    var body: some View {
        ZStack {
            switch viewModelForecast.state {
            case .loading:
                LoadingView()
            case .missingLocation:
                EnableLocationView(locationManager: viewModelForecast.locationManager)
            case .succes(let forecastResponse):
                ForecastViewContent(weather: previewForecast)
            case .error:
                ErrorFetchingDataView()
//            case .error(let string):
//                Text("We've got error \(string)")
            }
        }
        .task {
            await viewModelForecast.getForecast()
        }
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView()
    }
}
