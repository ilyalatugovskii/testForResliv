//
//  API.swift
//  weather
//
//  Created by Ilya Latugovskii on 26.03.2020.
//  Copyright © 2020 Ilya Latugovskii. All rights reserved.
//

import Foundation

struct API {
    static let sсheme = "https"
    static let host = "api.weather.yandex.ru"
    static let path = "/v1/forecast"
    
    static let lang = "ru_BY"
    static let limit = "7"
    static let hours = "true"
    static let extra = "false"
}
