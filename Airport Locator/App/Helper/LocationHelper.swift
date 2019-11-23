//
//  LocationHelper.swift
//  Airport Locator
//
//  Created by Mohd Taha on 21/11/2019.
//  Copyright © 2019 Mohd Taha. All rights reserved.
//

import Foundation
import CoreLocation

// MARK: - LocationAuthorizationStatus Protocol
protocol LocationAuthorizationStatus: NSObject {
    func statusAuthorizedAlways()
    func statusAuthorizedWhenInUse()
    func statusDenied()
    func statusNotDetermined()
    func statusRestricted()
    func userLocationUpdated()
}


class LocationHelper: NSObject {
    
    // MARK: - Private Variables
    private let locationManager = CLLocationManager()
    private static var instance: LocationHelper?
    private var userLocation = CLLocation()
    
    // MARK: - Public Variables
    public weak var callback: LocationAuthorizationStatus?
    
    // MARK: - Initializer Methods
    private override init() {}
}


// MARK: - CLLocationManagerDelegate
extension LocationHelper: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if let listener = callback {
            switch status {
            case .authorizedAlways:
                listener.statusAuthorizedAlways()
            case .authorizedWhenInUse:
                listener.statusAuthorizedWhenInUse()
            case .denied:
                listener.statusDenied()
            case .notDetermined:
                listener.statusNotDetermined()
            case .restricted:
                listener.statusRestricted()
            @unknown default:
                break
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocation = locations.last else { return }
        userLocation = location
        if let listener = callback {
            listener.userLocationUpdated()
        }
    }
    
    func isLocationServiceEnabled() -> Bool {
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                return false
            case .authorizedAlways, .authorizedWhenInUse:
                return true
            default:
                return false
            }
        } else {
            return false
        }
    }
    
    func getUserLocation() -> CLLocation {
        return userLocation
    }
}


// MARK: - Public Methods
extension LocationHelper {
    class var shared: LocationHelper {
        if instance == nil {
            instance = LocationHelper()
        }
        return instance!
    }
    
    class func assignCallback(_ callback: LocationAuthorizationStatus) -> LocationHelper {
        LocationHelper.shared.callback = callback //Always should be first, or Location Permission will be in dead lock in case of denied or restricted
        return LocationHelper.shared
    }
    
    public func listen() {
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startMonitoringSignificantLocationChanges()
        self.locationManager.startUpdatingLocation()
    }
}
