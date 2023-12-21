//
//  ForecastDetailView.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 28.11.2023.
//

import SwiftUI

extension Image {
    func imageSize() -> some View {
        self
            .resizable()
            .frame(maxWidth: 28.8, maxHeight: 28.8)
            .aspectRatio(contentMode: .fit)
    }
}

struct ForecastDetailView: View {
    
    var weather: ForecastResponse.ListResponse
    
    var body: some View {
        HStack(
            spacing: 17
            
        ) {
            ZStack {
                
                Circle()
                    .frame(maxWidth: 48, maxHeight: 48)
                    .cornerRadius(48)
                    .foregroundColor(.iconBase)
                Image(WeatherManager().getImageNameForForecastIcon(icon: weather.weather.first?.icon ?? ""))
                    .imageSize()
                
            }
            .padding(.leading, 16)
            
            VStack(
                alignment: .leading
                
            ) {
                Text("\(Date.formatUnixTimestampInGMT(weather.date))")
                    .modifier(ContentMediumModifier())
                Text(WeatherManager().getWeatherInfoFormForecastIcon(icon: weather.weather.first?.icon ?? ""))
                    .modifier(ContentSmallInfoModifier())
            }
            
            Spacer()
            
            Text("\(Int(weather.main.temp.kelvinToCelsius()))ºC")
                .modifier(HeadlineThreeModifier())
            
                .padding()
        }
        .frame(maxWidth: .infinity)
        .background(.row)
        .cornerRadius(16)
        
    }
}

struct ForecastDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastDetailView(weather: previewForecast.list.first ?? .init(date: 1702749600, main: .init(temp: 0), weather: []))
    }
}
