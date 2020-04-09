//
//  ActualWeatherViewController.swift
//  weather
//
//  Created by Ilya Latugovskii on 02.04.2020.
//  Copyright © 2020 Ilya Latugovskii. All rights reserved.
//

import UIKit

protocol ActualWeatherInformationViewModel {
    var nameOfCity: String { get }
    var brefWeather: String { get }
    var temperature: Int { get }
}

class ActualWeatherViewController: UIViewController {

    @IBOutlet weak var nameOfCityLabel: UILabel!
    @IBOutlet weak var brefWeatherLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    func changeLabels(with actualInformation: ActualWeatherInformationViewModel) {
        nameOfCityLabel.text = actualInformation.nameOfCity
        brefWeatherLabel.text = actualInformation.brefWeather
        temperatureLabel.text = String(actualInformation.temperature)
    }
}

