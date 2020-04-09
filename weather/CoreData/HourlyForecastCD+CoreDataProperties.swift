//
//  HourlyForecastCD+CoreDataProperties.swift
//  weather
//
//  Created by Ilya Latugovskii on 07.04.2020.
//  Copyright © 2020 Ilya Latugovskii. All rights reserved.
//
//

import Foundation
import CoreData


extension HourlyForecastCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HourlyForecastCD> {
        return NSFetchRequest<HourlyForecastCD>(entityName: "HourlyForecastCD")
    }

    @NSManaged public var hour: String?
    @NSManaged public var temperature: Float
    @NSManaged public var dailyForecasts: DailyForecastCD?

}
