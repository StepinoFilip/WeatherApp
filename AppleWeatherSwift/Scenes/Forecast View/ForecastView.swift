//
//  ForecastView.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 01.11.2023.
//

import SwiftUI

struct ForecastView: View {
    var weather: ForecastResponse
    let headerText = "Forecast"
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 1)
    
    var groupedData: [String: [ForecastResponse.ListResponse]] {
        var groupedData: [String: [ForecastResponse.ListResponse]] = [:]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"  
        
        for forecast in weather.list {
            let dateString = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(forecast.date)))
            
            if var existingData = groupedData[dateString] {
                existingData.append(forecast)
                groupedData[dateString] = existingData
            } else {
                groupedData[dateString] = [forecast]
            }
        }
        
        return groupedData
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(headerText)
                .font(.headlineTwo)
                .foregroundStyle(.mainText)
            
            NavigationView {
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(Array(groupedData.keys.sorted().enumerated()), id: \.1) { dayIndex, dateString in
                        let forecasts = groupedData[dateString]!
                        
                        LazyVGrid(columns: columns, spacing: 8, pinnedViews: [.sectionHeaders]) {
                            Section(header: ForecastHeaderInfoView(dayIndex: dayIndex)
                            ) {
                                ForEach(forecasts, id: \.date) { forecast in
                                    ForecastDetailView(weather: forecast)
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
        ForecastView(weather: previewForecast)
    }
}
