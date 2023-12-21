//
//  MyLocationView.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 01.11.2023.
//

import SwiftUI

struct TodayView: View {
    
    @State private var shouldPresentShareSheet = false
    
    var weather: CurrentResponse
    
    var body: some View {
        ZStack{
            AnimationBackgroundView()
            
            VStack (
                alignment: .leading
            ){
                HStack {
                    Spacer()
                    
                    shareButton
                }
                
                Spacer()
                
                VStack (
                    alignment: .leading,
                    spacing: 48
                ){
                    
                    Text(WeatherManager().getWeatherInfoFormWeatherIcon(icon: weather.weather.first?.icon ?? "", temperature: weather.main.temp))
                        .modifier(TitleModifier())
                        .foregroundColor(.mainText)
                    
                    VStack(
                        alignment: .leading,
                        spacing: 4
                        
                    ){
                        todayInformation
                    }
                }
                
                .padding(.vertical, 20)
                VStack (
                    alignment: .leading,
                    spacing: 15
                ){
                    Rectangle()
                        .frame(maxHeight: 1)
                        .foregroundColor(.devider)
                    
                    TodayDetailInfo(weather: previewWeather)
                    
                    Rectangle()
                        .frame(maxHeight: 1)
                        .foregroundColor(.devider)
                }
            }
            .padding()
        }
        .background(ShareSheetView(shouldPresent: $shouldPresentShareSheet, activityItems: ["Your shared content goes here"]))
    }
    
    var shareButton: some View {
        Button(action: {
            print("Button pressed Share")
            shouldPresentShareSheet.toggle()
        }) {
            Text("Share")
                .cornerRadius(40)
                .accentColor(.tabBar)
                .font(.buttons)
                .foregroundStyle(.shareButtonText)
        }
        .buttonStyle(ShareButton())
    }
    
    @ViewBuilder
    var todayInformation: some View {
        Image(WeatherManager().getImageNameForWeatherIcon(icon: weather.weather.first?.icon ?? ""))
            .resizable()
            .scaledToFit()
            .aspectRatio(contentMode: .fit)
            .frame(minWidth: 40, maxWidth: 40)
//        Text("\(Int(weather.main.temp.kelvinToCelsius().rounded()))ºC")
        Text("\(Int(weather.main.temp.rounded()))ºC")
            .modifier(TemperatureModifier())
            .padding(.vertical, 4)
        
        Text(weather.name + ", " + (countryName(countryCode: weather.sys.country) ?? "Unknown"))
            .modifier(ContentModifier())
            .padding(.vertical, 8)
    }
}




struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView(weather: previewWeather)
    }
}


//import SwiftUI
//
//struct TodayView: View {
//
//    @StateObject var locationManager = LocationManager()
//
//    var body: some View {
//        ZStack{
//            AnimationBackgroundView()
//
//            VStack (
//                alignment: .leading
//            ){
//                HStack {
//                    Spacer()
//
//                    Button() {
//                        print("Button pressed Share")
//                    } label: {
//                        Text("Share")
//                            .cornerRadius(40)
//                            .accentColor(.tabBar)
//                            .font(.buttons)
//                            .foregroundStyle(.shareButtonText)
//                    }
//                    .buttonStyle(ShareButton())
//                }
//
//                Spacer()
//
//                VStack (
//                    alignment: .leading,
//                    spacing: 48
//                ){
//
//                    Text("its.raining")
//                        .modifier(TitleModifier())
//                        .foregroundColor(.mainText)
//
//                    VStack(
//                        alignment: .leading,
//                        spacing: 4
//
//                    ){
//                        Image(.todayRain)
//                            .resizable()
//                            .scaledToFit()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(minWidth: 40, maxWidth: 40)
//
//                        Text("19°C")
//                            .modifier(TemperatureModifier())
//                            .padding(.vertical, 4)
//
//                        Text("Prague, Czech Republic")
//                            .modifier(ContentModifier())
//                            .padding(.vertical, 8)
//                    }
//                }
//
//                .padding(.vertical, 20)
//                VStack (
//                    alignment: .leading,
//                    spacing: 15
//                ){
//                    Rectangle()
//                        .frame(maxHeight: 1)
//                        .foregroundColor(.devider)
//
//                    TodayDetailInfo()
//
//                    Rectangle()
//                        .frame(maxHeight: 1)
//                        .foregroundColor(.devider)
//                }
//            }
//            .padding()
//
//
//        }
//    }
//}
//struct TodayView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodayView()
//    }
//}
//
