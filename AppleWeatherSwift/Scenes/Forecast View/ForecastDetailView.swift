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
    
    var weather: ResponseBody
    
    var body: some View {
        HStack(
            spacing: 17
            
        ) {
            ZStack {
                
                Circle()
                    .frame(maxWidth: 48, maxHeight: 48)
                    .cornerRadius(48)
                    .foregroundColor(.iconBase)
                Image(WeatherManager().getImageNameForWeatherIcon(icon: weather.weather.first?.icon ?? ""))
                    .imageSize()
                
            }
            .padding(.leading, 16)
            
            VStack(
                alignment: .leading
                
            ) {
                Text("\(Int(weather.list.dttxt))")
                    .modifier(ContentMediumModifier())
                Text(WeatherManager().getWeatherInfoFormWeatherIcon(icon: weather.weather.first?.icon ?? "", temperature: weather.main.temp))
                    .modifier(ContentSmallInfoModifier())
            }
            
            Spacer()
            
            Text("\(Int(weather.list.main.temp.rounded()))ºC")
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
        ForecastDetailView(weather: previewWeatherForecast)
    }
}
