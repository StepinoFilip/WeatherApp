//
//  ErrorFetchingDataViewContent.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 09.01.2024.
//

//import SwiftUI
//
//struct ErrorFetchingDataViewContent: View {
//    
//    @StateObject private var viewModelToday = TodayViewModel()
//    @StateObject private var viewModelForecast = ForecastViewModel()
//    
//    var body: some View {
//        ZStack{
//            
//            AnimationBackgroundView()
//            
//            VStack (
//                alignment: .leading,
//                spacing: 40
//            ){
//                HStack {
//                    Spacer()
//                    
//                Button(action: {
//                        print("Button pressed Reload")
//                    viewModelToday.shouldReloaded.toggle()
//                    viewModelForecast.shouldReloaded.toggle()
//                }) {
//                    Image.systemReload
//                    .cornerRadius(40)
//                    .accentColor(.tabBar)
//                        
//                    }
//                    .buttonStyle(ReloadButton())
//                }
//                
//                Image.systemWarning
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 49)
//                
//                Text("Error fetching data")
//                    .modifier(TitleModifier())
//                    .foregroundColor(.mainText)
//                
//                Text("Reload the location or search for a different one.")
//                    .modifier(ErrorInfoModifier())
//                
//                Spacer()
//                
//            }
//            .padding(.top, 16)
//            .padding()
//            
//        }
//    }
//}
//
//#Preview {
//    ErrorFetchingDataViewContent()
//}
//
