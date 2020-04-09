//
//  WeatherRouter.swift
//  weather
//
//  Created by Ilya Latugovskii on 23.03.2020.
//  Copyright (c) 2020 Ilya Latugovskii. All rights reserved.
//

import UIKit
import CoreData

protocol WeatherRoutingLogic {
    func save(weatherViewModel: WeatherViewModel)
    func read() -> WeatherViewModel?
}

class WeatherRouter: NSObject, WeatherRoutingLogic {

  weak var viewController: WeatherViewController?
    
  // MARK: Routing
    
    func save(weatherViewModel: WeatherViewModel) {
       
        deleteAllData(entity: HourlyForecastCD.description())
        deleteAllData(entity: DailyForecastCD.description())
        deleteAllData(entity: WeatherInformationCD.description())
        
        let hourlyForecastsSet = HourlyForecastCD.getArraySavedData(weatherCells: weatherViewModel.cellsCollection)
        let dailyForecastsSet = DailyForecastCD.getArraySavedData(weatherCells: weatherViewModel.cellsTable, with: hourlyForecastsSet)
        
        WeatherInformationCD.putInDataBase(weatherViewModel: weatherViewModel, with: dailyForecastsSet)
    }
    
    func read() -> WeatherViewModel? {
        let hoirlyForecast = HourlyForecastCD.getHourlyForecasts()
        let dailyForecas = DailyForecastCD.getDailyForecast()
        let weatherInformationArray = WeatherInformationCD.getWeatherInformation()
        guard let weatherInformation = weatherInformationArray.first else { return nil }
        
        var cellstable: [WeatherViewModel.CellTable] = []

        dailyForecas.forEach { (daily) in
            let cellTable = WeatherViewModel.CellTable(day: daily.dayOfWeek!,
                                                       icon: "",
                                                       maxTemperature: Int(daily.maxTemperature),
                                                       minTemperature: Int(daily.minTemperature))
            cellstable.append(cellTable)
        }
        
        var cellsCollection: [WeatherViewModel.CellCollection] = []
        hoirlyForecast.forEach { (hourly) in
            let cellCollection = WeatherViewModel.CellCollection(time: hourly.hour!,
                                                                 icon: "",
                                                                 temperature: Int(hourly.temperature))
            cellsCollection.append(cellCollection)
        }
        
        let additionalInformation = WeatherViewModel.AdditionalInformation(today: weatherInformation.todayConditions!,
                                                                           sinrise: weatherInformation.sunRise!,
                                                                           sunset: weatherInformation.sunSet!,
                                                                           changeOfSnow: weatherInformation.changeOfSnow!,
                                                                           humidity: Int(weatherInformation.humidity),
                                                                           wind: Int(weatherInformation.wind),
                                                                           feelsLike: Int(weatherInformation.feelsLike),
                                                                           precipitation: weatherInformation.precipitation,
                                                                           pressure: Int(weatherInformation.pressure),
                                                                           visibility: weatherInformation.visibility!,
                                                                           uvIndex: Int(weatherInformation.uvIndex))
        
        let actualInformation = WeatherViewModel.ActualWeatherInformation(nameOfCity: weatherInformation.nameOfCity!,
                                                                          brefWeather: weatherInformation.brefWeather!,
                                                                          temperature: Int(weatherInformation.temperature))
        
        let weatherViewModel = WeatherViewModel(cellsTable: cellstable,
                                                cellsCollection: cellsCollection,
                                                additionalInformation: additionalInformation,
                                                actualInfo: actualInformation)
        
        return weatherViewModel

    }
    
    private func deleteAllData(entity: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
        }
    }
}
