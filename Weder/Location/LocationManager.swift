//
//  LocationManager.swift
//  Weder
//
//  Created by Behnam on 8/16/22.
//

import Foundation
import CoreLocation

enum LocationPermissionStatus {
    case granted, notGranted
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()
    @Published var locationStatus: LocationPermissionStatus?
    @Published var lastLocation: CLLocation?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestForLocation() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse, .authorized:
            locationManager.startUpdatingLocation()
            locationStatus = .granted
        default:
            locationStatus = .notGranted
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        lastLocation = location
        locationManager.stopUpdatingLocation()
    }
}
