//
//  TodayDetailInfo.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 25.11.2023.
//

import SwiftUI

extension Image {
    func imageFrameShape() -> some View {
        self
            .frame(width: 40, height: 40)
            .background(.todayImageSpahe)
            .cornerRadius(40)
    }
}

struct TodayDetailInfo: View {
    
    var weather: CurrentResponse
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 20
        ){
            HStack(
                spacing: 50
            ){
                VStack (
                    alignment: .leading
                ){
                    Image(.todayHumidity)
                        .imageFrameShape()
                    
                    Text(weather.main.humidity.roundDouble() + "%")
                        .modifier(ContentSmallModifier())
                    
                    Text("Humidity")
                        .modifier(ContentSmallInfoModifier())
                }
                
                VStack (
                    alignment: .leading
                ){
                    Image(.todayPrecipitation)
                        .imageFrameShape()
                    
                    Text("\(Int((weather.rain?.oneHour ?? 0)))MM")
//                    Text("1MM")
                        .modifier(ContentSmallModifier())
                    
                    Text("Precipitation")
                        .modifier(ContentSmallInfoModifier())
                }
                
                VStack (
                    alignment: .leading
                ){
                    Image(.todayPressure)
                        .imageFrameShape()
                    
                    Text("\(weather.main.pressure.roundDouble())hPa")
                        .modifier(ContentSmallModifier())
                    
                    Text("Pressure")
                        .modifier(ContentSmallInfoModifier())
                }
            }
            
            .padding(.vertical, 10)
            
            HStack()
            {
                VStack (
                    alignment: .leading
                ){
                    Image(.todayWindSpeed)
                        .imageFrameShape()
                    
                    Text(String(weather.wind.speed.metersPerSecondToKilometersPerHour().roundDouble()) + "KM/H")
                        .modifier(ContentSmallModifier())
                    
                    Text("Wind")
                        .modifier(ContentSmallInfoModifier())
                }
                
                VStack (
                    alignment: .leading
                ){
                    Image(.todayWindDirection)
                        .imageFrameShape()
                    
                    Text(weather.wind.windDirection)
                        .modifier(ContentSmallModifier())
                    
                    Text("Direction")
                        .modifier(ContentSmallInfoModifier())
                }
                .padding(.horizontal, 50)
            }
        }
    }
}

#Preview {
    TodayDetailInfo(weather: previewWeather)
}
