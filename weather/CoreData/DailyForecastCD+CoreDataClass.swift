//
//  DailyForecastCD+CoreDataClass.swift
//  weather
//
//  Created by Ilya Latugovskii on 07.04.2020.
//  Copyright © 2020 Ilya Latugovskii. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(DailyForecastCD)
public class DailyForecastCD: NSManagedObject {
    
    public static func getDailyForecast() -> [DailyForecastCD] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let sortDescriptor = NSSortDescriptor(key: "dayOfWeek", ascending: true)
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: self.description())
        request.sortDescriptors = [sortDescriptor]
        request.returnsObjectsAsFaults = false
        do {
            
            if let result = try managedObjectContext.fetch(request) as? [DailyForecastCD] {
                return result
            }
        } catch { }
        return [DailyForecastCD]()
    }
    
    static func getArraySavedData(weatherCells: [WeatherTableCellViewModel], with setHourlyForecats: NSMutableSet) -> NSMutableSet {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let set = NSMutableSet()
        
        weatherCells.forEach { (weatherCell) in
            if let dailyForecasts = NSEntityDescription.insertNewObject(forEntityName: self.description(), into: managedObjectContext) as? DailyForecastCD {
                
                if weatherCell.day == "Понедельник" {
                    dailyForecasts.hourlForecasts = setHourlyForecats
                }
                dailyForecasts.dayOfWeek = weatherCell.day
                dailyForecasts.maxTemperature = Int32(weatherCell.maxTemperature)
                dailyForecasts.minTemperature = Int32(weatherCell.minTemperature)
                set.add(dailyForecasts)
            }
        }
        
        do {
            try managedObjectContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        
        return set
        
        
        
    }
}
