//
//  ForecastView.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 01.11.2023.
//

import SwiftUI

struct ForecastView: View {
    
    var weather: ResponseBody
    let headerText = "Forecast"
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 1)
    
    var vGridLayout = [ GridItem(.flexible()) ]
    
    var body: some View {
        VStack(
            alignment: .leading
        ){
            Text(headerText)
                .font(.headlineTwo)
                .foregroundStyle(.mainText)
            
            NavigationView {
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    ForEach(0..<5) { dayIndex in
                        LazyVGrid(columns: columns, spacing: 8, pinnedViews: [.sectionHeaders]) {
                            Section(header: ForecastHeaderInfoView(dayIndex: dayIndex)
                            ) {
                                ForEach(0..<8) { i in
                                    let weatherDataForecast = WeatherDataForecast(
                                        forecastImage: Image(.forecastSun),
                                        timeInfo: "Now",
                                        forecastInfo: "Clear Sky",
                                        forecastTemperature: "19°C"
                                    )
                                    ForecastDetailView(weatherDataForecsat: weatherDataForecast)
                                }
                            }
                        }
                    }
                    
                }
            }
        }
        .padding(.top, 30)
        .padding()
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView(weather: previewWeatherForecast)
    }
}
