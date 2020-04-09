//
//  WeatherTableViewCell.swift
//  weather
//
//  Created by Ilya Latugovskii on 27.03.2020.
//  Copyright © 2020 Ilya Latugovskii. All rights reserved.
//

import UIKit

protocol WeatherTableCellViewModel {
    var day: String { get }
    var icon: String { get }
    var maxTemperature: Int { get }
    var minTemperature: Int { get }
}

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var hourlyForecastCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
        hourlyForecastCollectionView.delegate = dataSourceDelegate
        hourlyForecastCollectionView.dataSource = dataSourceDelegate
        hourlyForecastCollectionView.tag = row
        hourlyForecastCollectionView.reloadData()
    }
    
    func setCell(weatherTableCellViewModel: WeatherTableCellViewModel) {
        dayLabel.text = weatherTableCellViewModel.day
        let url = "https://yastatic.net/weather/i/icons/blueye/color/svg/\(weatherTableCellViewModel.icon).svg"
        iconImageView.set(imageURL: url)
        maxTemperatureLabel.text = String(weatherTableCellViewModel.maxTemperature)
        minTemperatureLabel.text = String(weatherTableCellViewModel.minTemperature)
    }
}
