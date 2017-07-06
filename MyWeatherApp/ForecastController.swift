//
//  ForecastController.swift
//  MyWeatherApp
//
//  Created by 123 on 04.07.17.
//  Copyright © 2017 taras team. All rights reserved.
//

import LBTAComponents

class ForecastController: DatasourceController {
    
    var cityName: String?
    
    var location: String?
    
    var forecastdays = [Forecastday]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        collectionView?.alwaysBounceVertical = false
        layout?.scrollDirection = .horizontal
        collectionView?.isPagingEnabled = true
        collectionView?.backgroundColor = .blue
        
        collectionView?.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 300, leftConstant: 0, bottomConstant: 200, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        automaticallyAdjustsScrollViewInsets = false
        
        let datasource = ForecastDatasource()
        self.datasource = datasource
        
        navigationItem.title = cityName!
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backPressed))
        
        WeatherService.sharedInstance.getForecast(cityName: cityName!) { (forecast) in
            self.forecastdays.removeAll()
            self.setForecastdays(infoDic: forecast)
            datasource.forecasts = self.forecastdays
            self.collectionView?.reloadData()
        }
        
    }
    
    func backPressed() {
        dismiss(animated: false, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
    func setForecastdays(infoDic: [String: Any]) {
        guard let forecastDic = infoDic["forecast"] as? [String: Any] else { return }
        guard let forecastdays = forecastDic["forecastday"] as? [[String: Any]] else { return }
        
        for forecast in forecastdays {
            let day = Forecastday(forecast: forecast)
            self.forecastdays.append(day)
        }
    }
    
}
