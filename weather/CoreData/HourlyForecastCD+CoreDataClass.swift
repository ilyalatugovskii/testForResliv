//
//  HourlyForecastCD+CoreDataClass.swift
//  weather
//
//  Created by Ilya Latugovskii on 07.04.2020.
//  Copyright © 2020 Ilya Latugovskii. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(HourlyForecastCD)
public class HourlyForecastCD: NSManagedObject {
    
    public static func getHourlyForecasts() -> [HourlyForecastCD] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let sortDescriptor = NSSortDescriptor(key: "hour", ascending: true)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: self.description())
        request.sortDescriptors = [sortDescriptor]
        request.returnsObjectsAsFaults = false
        do {
            
            if let result = try managedObjectContext.fetch(request) as? [HourlyForecastCD] {
                return result
            }
        } catch { }
        return [HourlyForecastCD]()
    }
    
    static func getArraySavedData(weatherCells: [WeatherCollectionCellViewModel]) -> NSMutableSet {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let set = NSMutableSet()
        
        weatherCells.forEach { (weatherCell) in
            if let hourlyForecastsCD = NSEntityDescription.insertNewObject(forEntityName: self.description(), into: managedObjectContext) as? HourlyForecastCD {
                hourlyForecastsCD.hour = weatherCell.time
                hourlyForecastsCD.temperature = Float(weatherCell.temperature)
                set.add(hourlyForecastsCD)
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
