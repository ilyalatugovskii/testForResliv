//
//  WeatherAPI.swift
//  weather
//
//  Created by Ilya Latugovskii on 26.03.2020.
//  Copyright © 2020 Ilya Latugovskii. All rights reserved.
//

import Foundation

struct WeatherAPI: Codable {
    var tzinfo: TZInfo?
    var fact: Fact?
    var forecasts: [Forecasts]
}

struct TZInfo: Codable {
    var name: String
}

struct Fact: Codable {
    var temp: Int
    var feels_like: Int
    var icon: String
    var condition: String
    var wind_speed: Int
    var wind_dir: String
    var pressure_pa: Int
    var humidity: Int
    var prec_type: Int?
    var prec_strength: Double?
    var cloudness: Int?
   
}

struct Forecasts: Codable {
    var sunrise: String
    var sunset: String
    var temp_min: Int?
    var temp_max: Int?
    var icon: String?
    var hours: [Hours]
    var hour: String?
    var prec_mm: Float?
}

struct Hours: Codable {
    var hour: String
    var temp: Int
    var icon: String
}
