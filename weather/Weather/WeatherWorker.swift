//
//  WeatherWorker.swift
//  weather
//
//  Created by Ilya Latugovskii on 23.03.2020.
//  Copyright (c) 2020 Ilya Latugovskii. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherService {
    private let networkService = NetworkService()
    private let locationService = LocationServise()
    private var isSelectedLocation = false
    
    func request(with params: [String : String], completion: @escaping (WeatherAPI) -> Void) {
        networkService.request(params: params) { (data, error) in
            if let data = data {
                let needModel = try! JSONDecoder().decode(WeatherAPI.self, from: data)
                print(needModel)
                completion(needModel)
            }
        }
    }
    
    func getLocation(completion: @escaping ([String: String]) -> Void ) {
        locationService.locationPickedBlock = { [weak self] (params) in
            guard let self = self else { return }
            if !self.isSelectedLocation {
                self.isSelectedLocation = true
                completion(params)
            }
        }
    }
}
