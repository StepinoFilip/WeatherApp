//
//  TodayDetailInfo.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 25.11.2023.
//

import SwiftUI

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
                    
                    Text("humidity.title")
                        .modifier(ContentSmallInfoModifier())
                }
                
                VStack (
                    alignment: .leading
                ){
                    Image(.todayPrecipitation)
                        .imageFrameShape()
                    
                    Text("\(Int((weather.rain?.oneHour ?? 0)))MM")
                        .modifier(ContentSmallModifier())
                    
                    Text("precipitation.title")
                        .modifier(ContentSmallInfoModifier())
                }
                
                VStack (
                    alignment: .leading
                ){
                    Image(.todayPressure)
                        .imageFrameShape()
                    
                    Text("\(weather.main.pressure.roundDouble()) hPa")
                        .modifier(ContentSmallModifier())
                    
                    Text("pressure.title")
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
                    
                    Text("wind.title")
                        .modifier(ContentSmallInfoModifier())
                }
                
                VStack (
                    alignment: .leading
                ){
                    Image(.todayWindDirection)
                        .imageFrameShape()
                    
                    Text(weather.wind.windDirection)
                        .modifier(ContentSmallModifier())
                    
                    Text("direction.title")
                        .modifier(ContentSmallInfoModifier())
                }
                .padding(.horizontal, 55)
            }
        }
    }
}

#Preview {
    TodayDetailInfo(weather: previewWeather)
}
