//
//  test.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 10.01.2024.
//

import SwiftUI

struct test: View {
    
    var weather: ForecastResponse.ListResponse
    
    var body: some View {
        VStack{
            Text("\(Date.formatUnixTimestampInGMT(weather.date))")
                .modifier(ContentMediumModifier())
            
            Text("\(Date.formatUnixTimestampInGMT(weather.date)) ")
                .modifier(ContentMediumModifier())
        }
    }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test(weather: previewForecast.list.first ?? .init(date: 1702749600, main: .init(temp: 0), weather: []))
    }
}

