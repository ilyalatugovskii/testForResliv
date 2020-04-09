//
//  WeatherPresenter.swift
//  weather
//
//  Created by Ilya Latugovskii on 23.03.2020.
//  Copyright (c) 2020 Ilya Latugovskii. All rights reserved.
//

import UIKit

protocol WeatherPresentationLogic {
  func presentData(response: Weather.Model.Response.ResponseType)
}

class WeatherPresenter: WeatherPresentationLogic {
  weak var viewController: WeatherDisplayLogic?
  
    let daysOfWeak = ["Понедельник","Вторник","Среда","Четверг","Пятница","Суббота","Восресенье"]
    
  func presentData(response: Weather.Model.Response.ResponseType) {
    switch response {
        
    case .response(let weatherAPI):
        var i = 0
        let cellsTable = weatherAPI.forecasts.map { (forecast) -> WeatherViewModel.CellTable in
            i = i + 1
            return WeatherViewModel.CellTable(day: daysOfWeak[i-1],
                                              icon: forecast.icon ?? "",
                                              maxTemperature: forecast.temp_max ?? 0,
                                              minTemperature: forecast.temp_min ?? 0)
        }
        
        let cellsCollection = weatherAPI.forecasts[0].hours.map { (hour) -> WeatherViewModel.CellCollection in
            return WeatherViewModel.CellCollection(time: hour.hour,
                                                   icon: hour.icon,
                                                   temperature: hour.temp)
        }
        
        let additionalInformation = WeatherViewModel.AdditionalInformation(
            today: weatherAPI.fact?.condition ?? "",
            sinrise: weatherAPI.forecasts[0].sunrise ,
            sunset: weatherAPI.forecasts[0].sunset ,
            changeOfSnow: "10%",
            humidity: weatherAPI.fact?.humidity ?? 0,
            wind: weatherAPI.fact?.wind_speed ?? 0,
            feelsLike: weatherAPI.fact?.feels_like ?? 0,
            precipitation: weatherAPI.forecasts[0].prec_mm ?? 0,
            pressure: weatherAPI.fact?.pressure_pa ?? 0,
            visibility: "More",
            uvIndex: 1
        )
        
        let actualInformation = WeatherViewModel.ActualWeatherInformation(nameOfCity: weatherAPI.tzinfo?.name ?? "NIL",
                                                                          brefWeather: weatherAPI.fact?.condition ?? "",
                                                                          temperature: weatherAPI.fact?.temp ?? 100)
        
        let weatherViewModel = WeatherViewModel(cellsTable: cellsTable,
                                                cellsCollection: cellsCollection,
                                                additionalInformation: additionalInformation,
                                                actualInfo: actualInformation)
        
        viewController?.displayData(viewModel: .present(viewModel: weatherViewModel))
        
    case .prepareData(withParams: let params):
        viewController?.displayData(viewModel: .showLocation(withParams: params))
    }
  }
  
}
