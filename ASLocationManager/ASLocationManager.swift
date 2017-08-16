//
//  ASLocationManager.swift
//  ASLocationManager
//
//  Created by Anton Stremovskiy on 8/16/17.
//  Copyright © 2017 áSoft. All rights reserved.
//

import Foundation
import CoreLocation

protocol ASLocationManagerDelegate: class {
    
    func didUpdateLocation(lat: Double, lon: Double)
}


open class ASLocationManager: NSObject {
    
    static let shared = ASLocationManager()
    
    var locationManager = CLLocationManager()
    weak var delegate: ASLocationManagerDelegate?
    
    public static var desiredAccuracy: CLLocationAccuracy = kCLLocationAccuracyBest
    public static var distanceFilter: CLLocationDistance = 200
    
    private override init() {
        super.init()

        locationManager.delegate = self
    }
    
    func config(_ accuracy: CLLocationAccuracy) {
        locationManager.desiredAccuracy = ASLocationManager.desiredAccuracy
        locationManager.distanceFilter = ASLocationManager.distanceFilter
    }
    
    public func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    public func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
        locationManager.stopMonitoringSignificantLocationChanges()
    }
    
    public func checkForLocationPermissions(success:(_ result: Bool) -> Void, failure: @escaping (_ result: Error) -> Void)  {
        
        switch CLLocationManager.authorizationStatus() {
        case .restricted, .denied:
            
            failure(false as! Error)
            DispatchQueue.main.async {
                self.alertWithLocationSettings("Location service has been restricted or denied, please open Settings to allow using location")
            }
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            success(true)
        case .authorizedWhenInUse, .authorizedAlways:
            success(true)
            break
        }
    }
  
}

extension ASLocationManager: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint(error.localizedDescription)
        self.showAlert(error.localizedDescription)
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        delegate?.didUpdateLocation(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
    }
}

