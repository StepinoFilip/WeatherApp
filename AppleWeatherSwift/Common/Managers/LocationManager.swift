//
//  LocationManager.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 01.12.2023.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    
    @Published var location: CLLocationCoordinate2D?
    @Published var isLoading = false
    
    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = 500  // Minimum distance in meters
        manager.startUpdatingLocation()
    }
    
    func requestLocation() {
        isLoading = true
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
        isLoading = false
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            switch status {
            case .authorizedWhenInUse, .authorizedAlways:
                // Handle authorized status
                print("Location authorization granted")
            case .denied, .restricted:
                // Handle denied or restricted status
                print("Location authorization denied or restricted")
            case .notDetermined:
                // Handle not determined status
                print("Location authorization not determined")
                manager.requestWhenInUseAuthorization()
            @unknown default:
                break
            }
        }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let clError = error as? CLError {
            print("Location Manager Error: \(clError.errorCode) - \(clError.localizedDescription)")
        } else {
            print("Generic Location Manager Error: \(error.localizedDescription)")
        }
        isLoading = false
    }
    
    func stopLocationUpdates() {
          manager.stopUpdatingLocation()
      }
}
