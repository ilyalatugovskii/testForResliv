//
//  DailyForecastCD+CoreDataProperties.swift
//  weather
//
//  Created by Ilya Latugovskii on 07.04.2020.
//  Copyright © 2020 Ilya Latugovskii. All rights reserved.
//
//

import Foundation
import CoreData


extension DailyForecastCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyForecastCD> {
        return NSFetchRequest<DailyForecastCD>(entityName: "DailyForecastCD")
    }

    @NSManaged public var dayOfWeek: String?
    @NSManaged public var minTemperature: Int32
    @NSManaged public var maxTemperature: Int32
    @NSManaged public var hourlForecasts: NSSet?
    @NSManaged public var weatherInformations: WeatherInformationCD?

}

// MARK: Generated accessors for hourlForecasts
extension DailyForecastCD {

    @objc(addHourlForecastsObject:)
    @NSManaged public func addToHourlForecasts(_ value: HourlyForecastCD)

    @objc(removeHourlForecastsObject:)
    @NSManaged public func removeFromHourlForecasts(_ value: HourlyForecastCD)

    @objc(addHourlForecasts:)
    @NSManaged public func addToHourlForecasts(_ values: NSSet)

    @objc(removeHourlForecasts:)
    @NSManaged public func removeFromHourlForecasts(_ values: NSSet)

}
