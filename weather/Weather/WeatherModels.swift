//
//  WeatherModels.swift
//  weather
//
//  Created by Ilya Latugovskii on 23.03.2020.
//  Copyright (c) 2020 Ilya Latugovskii. All rights reserved.
//

import UIKit

enum Weather {
   
  enum Model {
    struct Request {
      enum RequestType {
        case request(withParams: [String:String])
        case getLocation
      }
    }
    struct Response {
      enum ResponseType {
        case response(weatherAPI: WeatherAPI)
        case prepareData(withParams: [String:String])
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case present(viewModel: WeatherViewModel)
        case showLocation(withParams: [String:String])
      }
    }
  }
  
}

struct WeatherViewModel {
    struct CellTable: WeatherTableCellViewModel {
        var day: String
        var icon: String
        var maxTemperature: Int
        var minTemperature: Int
    }
    
    struct CellCollection: WeatherCollectionCellViewModel {
        var time: String
        var icon: String
        var temperature: Int
    }
    
    struct AdditionalInformation: WeatherAdditionalInformationViewModel {
        var today: String
        var sinrise: String
        var sunset: String
        var changeOfSnow: String
        var humidity: Int
        var wind: Int
        var feelsLike: Int
        var precipitation: Float
        var pressure: Int
        var visibility: String
        var uvIndex: Int
    }
    
    struct ActualWeatherInformation: ActualWeatherInformationViewModel {
        var nameOfCity: String
        var brefWeather: String
        var temperature: Int
    }
    
    var cellsTable: [CellTable]
    var cellsCollection: [CellCollection]
    var additionalInformation: AdditionalInformation
    var actualInfo: ActualWeatherInformation
}
