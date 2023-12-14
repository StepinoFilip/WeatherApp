//
//  ShareSheetView.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 05.12.2023.
//

import SwiftUI

struct ShareSheetView: UIViewControllerRepresentable {
    @Binding var shouldPresent: Bool
    var activityItems: [Any]

    func makeUIViewController(context: Context) -> UIViewController {
        UIViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if shouldPresent {
            let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
            uiViewController.present(activityViewController, animated: true) {
                shouldPresent = false
            }
        }
    }
}
