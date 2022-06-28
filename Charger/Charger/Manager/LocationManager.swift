//
//  LocationManager.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 28.06.2022.
//

import Foundation
import CoreLocation
import UIKit

class LocationManager: NSObject {
    
    // Set singleton instance as static to access it using class name
    static let shared = LocationManager()
    
    var locationManager: CLLocationManager?
    
    // Set init as private for preventing access from outside of class
    private override init() {
        super.init()
        
        // Making locationManager ready to use
        setupLocationManager()
    }
}


extension LocationManager: CLLocationManagerDelegate {
    
    // Initialize locationManager property and assign it as delegate
    private func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
    }
    
    // Request authorization to the user
    func requestAuthorization() {
        locationManager?.requestWhenInUseAuthorization()
    }
    
    /**
     This function performs corresponding response to the authorization status
     that the user set for location.
     */
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        
        switch status {
        case .notDetermined:
            requestAuthorization()
        case .denied:
            manager.stopUpdatingLocation()
        case .authorizedWhenInUse:
            manager.startUpdatingLocation()
        default:
            print("Location authorization status does not exist in any of the cases!")
        }
    }

}


