//
//  TodayViewContent.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 08.01.2024.
//

import SwiftUI

struct TodayViewContent: View {
    
    @StateObject private var viewModel = TodayViewModel()
    var weatherManager = WeatherManager()
    
    var weather: CurrentResponse
    
    var body: some View {
        
        ZStack {
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
        .background(ShareSheetView(shouldPresent: $viewModel.shouldPresentShareSheet, activityItems: ["Your shared content goes here"]))
    }
    
    var shareButton: some View {
        Button(action: {
            print("Button pressed Share")
            viewModel.shouldPresentShareSheet.toggle()
        }) {
            Text("share.button.title")
                .cornerRadius(40)
                .accentColor(.tabBar)
                .font(.buttons)
                .foregroundStyle(.shareButtonText)
        }
        .buttonStyle(ShareButton())
    }
    
    @ViewBuilder
    var todayInformation: some View {
        
        let temperature = Int(weather.main.temp.rounded())
        let temperatureWithUnits = "\(temperatureUnitSymbol())"
        
        Image(weatherManager.getImageNameForWeatherIcon(icon: weather.weather.first?.icon ?? ""))
            .resizable()
            .scaledToFit()
            .aspectRatio(contentMode: .fit)
            .frame(minWidth: 40, maxWidth: 40)
        
        Text(temperatureWithUnits)
            .modifier(TemperatureModifier())
            .padding(.vertical, 4)
        
        //        Text("Unknown")
        Text(weather.name + ", " + (countryName(countryCode: weather.sys.country) ?? "Unknown"))
            .modifier(ContentModifier())
            .padding(.vertical, 8)
    }
    
    func temperatureUnitSymbol() -> String {
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        
        let temperature = Measurement(value: weather.main.temp, unit: UnitTemperature.celsius)
        return measurementFormatter.string(from: temperature)
    }
}


struct TodayViewContent_Previews: PreviewProvider {
    static var previews: some View {
        TodayViewContent(weather: previewWeather)
    }
}

