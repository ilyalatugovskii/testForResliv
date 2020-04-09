//
//  WeatherInformationCD+CoreDataClass.swift
//  weather
//
//  Created by Ilya Latugovskii on 07.04.2020.
//  Copyright © 2020 Ilya Latugovskii. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(WeatherInformationCD)
public class WeatherInformationCD: NSManagedObject {
    public static func getWeatherInformation() -> [WeatherInformationCD] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: self.description())
        request.returnsObjectsAsFaults = false
        do {
            
            if let result = try managedObjectContext.fetch(request) as? [WeatherInformationCD] {
                return result
            }
        } catch { }
        return [WeatherInformationCD]()
    }
    
    static func putInDataBase(weatherViewModel: WeatherViewModel, with dailyForecastsSet: NSMutableSet) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let weatherInformationCD = NSEntityDescription.insertNewObject(forEntityName: self.description(), into: managedObjectContext) as! WeatherInformationCD
        
        weatherInformationCD.brefWeather = weatherViewModel.actualInfo.brefWeather
        weatherInformationCD.changeOfSnow = weatherViewModel.additionalInformation.changeOfSnow
        weatherInformationCD.feelsLike = Int32(weatherViewModel.additionalInformation.feelsLike)
        weatherInformationCD.humidity = Int32(weatherViewModel.additionalInformation.humidity)
        weatherInformationCD.nameOfCity = weatherViewModel.actualInfo.nameOfCity
        weatherInformationCD.precipitation = weatherViewModel.additionalInformation.precipitation
        weatherInformationCD.pressure = Float(weatherViewModel.additionalInformation.pressure)
        weatherInformationCD.sunRise = weatherViewModel.additionalInformation.sinrise
        weatherInformationCD.sunSet = weatherViewModel.additionalInformation.sunset
        weatherInformationCD.temperature = Int32(weatherViewModel.actualInfo.temperature)
        weatherInformationCD.todayConditions = weatherViewModel.actualInfo.brefWeather
        weatherInformationCD.uvIndex = Int16(weatherViewModel.additionalInformation.uvIndex)
        weatherInformationCD.visibility = weatherViewModel.additionalInformation.visibility
        weatherInformationCD.wind = Int32(weatherViewModel.additionalInformation.wind)
        
        weatherInformationCD.dailyForecasts = dailyForecastsSet
        
        do {
            try managedObjectContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
