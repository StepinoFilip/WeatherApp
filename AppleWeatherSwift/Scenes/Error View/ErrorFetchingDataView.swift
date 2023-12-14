//
//  ErrorFetchingDataView.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 23.11.2023.
//

import SwiftUI

struct ErrorFetchingDataView: View {
    var body: some View {
        VStack (
            alignment: .leading,
            spacing: 40
        ){
            HStack {
                Spacer()
                
                Button() {
                    print("Button pressed Reload")
                } label: {
                    Image.systemReload
                        .cornerRadius(40)
                        .accentColor(.tabBar)
                    
                }
                .buttonStyle(ReloadButton())
            }
            
            Image.systemWarning
                .resizable()
                .scaledToFit()
                .frame(width: 49)
            
            Text("Error fetching data")
                .modifier(TitleModifier())
                .foregroundColor(.mainText)
            
            Text("Reload the location or search for a different one.")
                .modifier(ErrorInfoModifier())
            
            Spacer()
            
        }
        .padding(.top, 16)
        .padding()
        
    }
}

#Preview {
    ErrorFetchingDataView()
}
