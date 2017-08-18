//
//  ViewController.swift
//  ASLocationManager
//
//  Created by Anton Stremovskiy on 8/16/17.
//  Copyright © 2017 áSoft. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let locationManager = ASLocationManager.shared
        locationManager.checkForLocationPermissions(success: { _ in
            
            locationManager.delegate = self
            locationManager.config(kCLLocationAccuracyBest)
            locationManager.startUpdatingLocation()
        })
    }
}

extension ViewController: ASLocationManagerDelegate {
    
    func didUpdateLocation(_ location: CLLocation) {
        debugPrint("lacation: \(location)")
    }
}

