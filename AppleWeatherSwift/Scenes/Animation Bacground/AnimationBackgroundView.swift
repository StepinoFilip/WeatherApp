//
//  test.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 27.11.2023.
//

import SwiftUI

struct AnimationBackgroundView: View {
    
    let color1 = Color.rain1
    let color2 = Color.rain2
    
    @State var xpos: CGFloat = 50
    @State var ypos: CGFloat = 0
    @State private var scale: CGFloat = 1.0
    @State private var pulsate: Bool = false
    
    var body: some View {
        ZStack {
            Circle()
                        .fill(
                            RadialGradient(
                                gradient: Gradient(colors: [color1, color2, .mainBackground]),
                                center: .center, startRadius: 0, endRadius: 400)
                            )
                        .frame(width: 500, height: 500)
                .foregroundColor(.blue)
                .blur(radius: 100)
                .scaleEffect(pulsate ? 1.5 : 1.0)
                .position(x: xpos, y: ypos)
                .animation(.easeInOut(duration: 7.0).repeatForever(autoreverses: true), value: xpos) // Animation follows the position modifier
                .onAppear() {
                    self.pulsate.toggle()

                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.mainBackground)
        .onAppear {
            xpos = 450 // Trigger the animation to start
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    AnimationBackgroundView()
}

//import SwiftUI
//
//struct AnimationBackgroundView: View {
//    
//    enum Weather: String {
//        case rainy = "10d"
//        case sunny = "01d"
//        case cloudy = "04d"
//        case unknown
//    }
//    
//    @State private var weather: Weather = .unknown
//    
//    var color1: Color {
//        switch weather {
//        case .sunny:
//            return .sun1
//        case .rainy:
//            return .rain1
//        case .cloudy:
//            return .cloudy1
//        case .unknown:
//            return .default1
//        }
//    }
//    
//    var color2: Color {
//        switch weather {
//        case .sunny:
//            return .sun2
//        case .rainy:
//            return .rain2
//        case .cloudy:
//            return .cloudy2
//        case .unknown:
//            return .default2
//        }
//    }
//    
//    @State var xpos: CGFloat = 50
//    @State var ypos: CGFloat = 0
//    @State private var scale: CGFloat = 1.0
//    @State private var pulsate: Bool = false
//    
//    var body: some View {
//        ZStack {
//            Circle()
//                .fill(
//                    RadialGradient(
//                        gradient: Gradient(colors: [color1, color2, .mainBackground]),
//                        center: .center, startRadius: 0, endRadius: 400)
//                )
//                .frame(width: 500, height: 500)
//                .foregroundColor(.blue)
//                .blur(radius: 100)
//                .scaleEffect(pulsate ? 1.5 : 1.0)
//                .position(x: xpos, y: ypos)
//                .animation(.easeInOut(duration: 7.0).repeatForever(autoreverses: true), value: xpos) // Animation follows the position modifier
//                .onAppear() {
//                    self.pulsate.toggle()
//                }
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(.mainBackground)
//        .onAppear {
//            xpos = 450 // Trigger the animation to start
//        }
//        .onTapGesture {
//            toggleWeather()
//        }
//        .ignoresSafeArea(.all)
//    }
//    
//    private func toggleWeather() {
//        switch weather {
//        case .rainy:
//            weather = .sunny
//        case .sunny:
//            weather = .cloudy
//        case .cloudy:
//            weather = .unknown
//        case .unknown:
//            weather = .rainy
//        }
//    }
//}
//
//struct AnimationBackgroundView_Previews: PreviewProvider {
//    static var previews: some View {
//        AnimationBackgroundView()
//    }
//}
//
