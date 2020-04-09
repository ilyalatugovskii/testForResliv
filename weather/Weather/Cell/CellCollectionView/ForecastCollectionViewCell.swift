//
//  ForecastCollectionViewCell.swift
//  weather
//
//  Created by Ilya Latugovskii on 27.03.2020.
//  Copyright © 2020 Ilya Latugovskii. All rights reserved.
//

import UIKit

protocol WeatherCollectionCellViewModel {
    var time: String { get }
    var icon: String { get }
    var temperature: Int { get }
}

class ForecastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    func setCollectionCell(weatherCollectionCellViewModel: WeatherCollectionCellViewModel) {
        timeLabel.text = weatherCollectionCellViewModel.time
        let url = "https://yastatic.net/weather/i/icons/blueye/color/svg/\(weatherCollectionCellViewModel.icon).svg"
        iconImageView.set(imageURL: url)
        temperatureLabel.text = String(weatherCollectionCellViewModel.temperature)
    }
}
