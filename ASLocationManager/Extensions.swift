//
//  Extensions.swift
//  ASLocationManager
//
//  Created by Anton Stremovskiy on 8/16/17.
//  Copyright © 2017 áSoft. All rights reserved.
//

import Foundation
import UIKit


extension ASLocationManager {
    
    public func showAlert(_ withText: String) {
        
        let alert  = UIAlertController(title: "Error", message: withText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        UIApplication.shared.delegate?.window??.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    public func alertWithLocationSettings(_ withText: String) {
        
        let alert  = UIAlertController(title: "Error", message: withText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Open Location Settings", style: .default, handler: { _ in
            
            let path = UIApplicationOpenSettingsURLString
            if let settingsURL = URL(string: path), UIApplication.shared.canOpenURL(settingsURL) {
                UIApplication.shared.openURL(settingsURL)
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        UIApplication.shared.delegate?.window??.rootViewController?.present(alert, animated: true, completion: nil)
    }

}
