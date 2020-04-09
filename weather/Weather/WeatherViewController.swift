//
//  WeatherViewController.swift
//  weather
//
//  Created by Ilya Latugovskii on 23.03.2020.
//  Copyright (c) 2020 Ilya Latugovskii. All rights reserved.
//

import UIKit

protocol WeatherDisplayLogic: class {
    func displayData(viewModel: Weather.Model.ViewModel.ViewModelData)
}

class WeatherViewController: UIViewController, WeatherDisplayLogic {
    
    enum Constants {
        static let hourlyWeatherTableIdentifire = "HourlyWeatherForecastCell"
        static let forecastCollectionIdentifire = "ForecastCollectionViewCell"
        static let weatherTableIdentifire = "WeatherCell"
        static let heightCellWithCollection: CGFloat = 132
        static let heightCell: CGFloat = 50
    }
    
    @IBOutlet weak var weatherTableView: UITableView!
    
    var interactor: WeatherBusinessLogic?
    var router: (NSObjectProtocol & WeatherRoutingLogic)?
    
    var weatherViewModel: WeatherViewModel? {
        didSet {
            updateadAdditionalInformation()
            weatherTableView.reloadData()
        }
    }
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = WeatherInteractor()
        let presenter             = WeatherPresenter()
        let router                = WeatherRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
    }
    
    // MARK: Routing
    
    
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
        if let viewModel = router?.read() {
            weatherViewModel = viewModel
        }
        //interactor?.makeRequest(request: .getLocation)
    }
    
    func displayData(viewModel: Weather.Model.ViewModel.ViewModelData) {
        switch viewModel {
            
        case .present(let viewModel):
            weatherViewModel = viewModel
            router?.save(weatherViewModel: viewModel)
        case .showLocation(withParams: let params):
            interactor?.makeRequest(request: .request(withParams: params))
        }
    }
    
    private func updateadAdditionalInformation() {
        if let actualVC = self.children.first(where: { $0 is ActualWeatherViewController }) {
            (actualVC as! ActualWeatherViewController).changeLabels(with: weatherViewModel!.actualInfo)
        }
        if let addVC = self.children.first(where: { $0 is WeatherAdditionalInformationViewController }) {
            (addVC as! WeatherAdditionalInformationViewController).changeLabels(with: weatherViewModel!.additionalInformation)
        }
    }
    
}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherViewModel?.cellsTable.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: WeatherTableViewCell
        
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: Constants.hourlyWeatherTableIdentifire, for: indexPath) as! WeatherTableViewCell
            cell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: Constants.weatherTableIdentifire, for: indexPath) as! WeatherTableViewCell
        }
        
        cell.setCell(weatherTableCellViewModel: (weatherViewModel?.cellsTable[indexPath.row])!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return Constants.heightCellWithCollection
        } else {
            return Constants.heightCell
        }
    }
    
}

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherViewModel?.cellsCollection.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.forecastCollectionIdentifire, for: indexPath) as! ForecastCollectionViewCell
        cell.setCollectionCell(weatherCollectionCellViewModel: (weatherViewModel?.cellsCollection[indexPath.row])!)
        
        return cell
    }
    
    
}
