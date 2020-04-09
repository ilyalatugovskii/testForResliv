//
//  Locale.swift
//  weather
//
//  Created by Ilya Latugovskii on 02.04.2020.
//  Copyright © 2020 Ilya Latugovskii. All rights reserved.
//

import Foundation
import CoreLocation

final class LocationServise: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    var locationPickedBlock: (([String: String]) -> Void)?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
          locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
          locationManager.requestLocation()
            locationManager.startUpdatingLocation()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let coordinate = manager.location!.coordinate
        let params = [(String(describing: coordinate.latitude)): (String(describing: coordinate.longitude))]
        locationPickedBlock?(params)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
  
}

