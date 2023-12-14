//
//  EnableLocationView.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 23.11.2023.
//

import SwiftUI
import CoreLocationUI

struct EnableLocationView: View {
    
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        VStack (
            alignment: .leading,
            spacing: 40
        ){
            Image.systemLocation
                .resizable()
                .scaledToFit()
                .frame(width: 49)
            
            Text("Enable Location")
                .modifier(TitleModifier())
                .foregroundColor(.mainText)
            
            
            Text("Give us permission to see forecast for your current location.")
                .modifier(ErrorInfoModifier())
            
            Button(action: {
                            locationManager.requestLocation()
                        print("Button pressed Enable location")
                        }) {
                Text("Enable location")
                    .font(.buttons)
                    .foregroundStyle(.enableLocationButtonText)
            }
            .buttonStyle(EnableButton())
            
            Spacer()
                
            }
        .padding(.top, 100)

        }
    }


#Preview {
    EnableLocationView()
}

