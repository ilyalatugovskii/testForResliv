//
//  WeatherInformationCD+CoreDataProperties.swift
//  weather
//
//  Created by Ilya Latugovskii on 07.04.2020.
//  Copyright © 2020 Ilya Latugovskii. All rights reserved.
//
//

import Foundation
import CoreData


extension WeatherInformationCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherInformationCD> {
        return NSFetchRequest<WeatherInformationCD>(entityName: "WeatherInformationCD")
    }

    @NSManaged public var nameOfCity: String?
    @NSManaged public var brefWeather: String?
    @NSManaged public var temperature: Int32
    @NSManaged public var todayConditions: String?
    @NSManaged public var sunRise: String?
    @NSManaged public var sunSet: String?
    @NSManaged public var changeOfSnow: String?
    @NSManaged public var humidity: Int32
    @NSManaged public var wind: Int32
    @NSManaged public var feelsLike: Int32
    @NSManaged public var precipitation: Float
    @NSManaged public var pressure: Float
    @NSManaged public var visibility: String?
    @NSManaged public var uvIndex: Int16
    @NSManaged public var dailyForecasts: NSSet?

}

// MARK: Generated accessors for dailyForecasts
extension WeatherInformationCD {

    @objc(addDailyForecastsObject:)
    @NSManaged public func addToDailyForecasts(_ value: DailyForecastCD)

    @objc(removeDailyForecastsObject:)
    @NSManaged public func removeFromDailyForecasts(_ value: DailyForecastCD)

    @objc(addDailyForecasts:)
    @NSManaged public func addToDailyForecasts(_ values: NSSet)

    @objc(removeDailyForecasts:)
    @NSManaged public func removeFromDailyForecasts(_ values: NSSet)

}
