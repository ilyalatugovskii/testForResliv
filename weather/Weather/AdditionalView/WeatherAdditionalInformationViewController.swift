//
//  WeatherAdditionalInformationViewController.swift
//  weather
//
//  Created by Ilya Latugovskii on 01.04.2020.
//  Copyright © 2020 Ilya Latugovskii. All rights reserved.
//

import UIKit

protocol WeatherAdditionalInformationViewModel {
    var today: String { get }
    var sinrise: String { get }
    var sunset: String { get }
    var changeOfSnow: String { get }
    var humidity: Int { get }
    var wind: Int { get }
    var feelsLike: Int { get }
    var precipitation: Float { get }
    var pressure: Int { get }
    var visibility: String { get }
    var uvIndex: Int { get }
}

class WeatherAdditionalInformationViewController: UIViewController {

    @IBOutlet weak var todayInformationLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var changeOfSnowLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var uvIndexLabel: UILabel!
    
    func changeLabels(with additionalInformation: WeatherAdditionalInformationViewModel) {
        todayInformationLabel.text = additionalInformation.today
        sunriseLabel.text = additionalInformation.sinrise
        sunsetLabel.text = additionalInformation.sunset
        changeOfSnowLabel.text = additionalInformation.changeOfSnow
        humidityLabel.text = String(additionalInformation.humidity)
        windLabel.text =  String(additionalInformation.wind)
        feelsLikeLabel.text =  String(additionalInformation.feelsLike)
        precipitationLabel.text = String(additionalInformation.precipitation)
        pressureLabel.text =  String(additionalInformation.pressure)
        visibilityLabel.text = additionalInformation.visibility
        uvIndexLabel.text = String(additionalInformation.uvIndex)
    }
}
