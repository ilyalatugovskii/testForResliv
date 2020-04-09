//
//  WeatherInteractor.swift
//  weather
//
//  Created by Ilya Latugovskii on 23.03.2020.
//  Copyright (c) 2020 Ilya Latugovskii. All rights reserved.
//

import UIKit

protocol WeatherBusinessLogic {
  func makeRequest(request: Weather.Model.Request.RequestType)
}

class WeatherInteractor: WeatherBusinessLogic {

  var presenter: WeatherPresentationLogic?
  var service: WeatherService?
  
  func makeRequest(request: Weather.Model.Request.RequestType) {
    if service == nil {
      service = WeatherService()
    }
    switch request {
        
    case .request(let params):
        service?.request(with: params, completion: { [weak self] (weatherAPI) in
            self?.presenter?.presentData(response: .response(weatherAPI: weatherAPI))
        })
    case .getLocation:
        service?.getLocation(completion: { [weak self] (params) in
            self?.presenter?.presentData(response: .prepareData(withParams: params))
        })
    }
    
  }
  
}
