//
//  LocationManager.swift
//  Weder
//
//  Created by Behnam on 8/16/22.
//

import CoreLocation
import Foundation

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
        requestForLocation()
    }

    func requestForLocation() {
        locationManager.requestWhenInUseAuthorization()
    }

    func locationManager(_: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse, .authorized:
            locationManager.startUpdatingLocation()
            locationStatus = .granted
        default:
            locationStatus = .notGranted
        }
    }

    func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        lastLocation = location
        locationManager.stopUpdatingLocation()
    }
}
