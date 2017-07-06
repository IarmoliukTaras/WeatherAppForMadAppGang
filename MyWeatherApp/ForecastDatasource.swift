//
//  ForecastDatasource.swift
//  MyWeatherApp
//
//  Created by 123 on 04.07.17.
//  Copyright © 2017 taras team. All rights reserved.
//

import LBTAComponents

class ForecastDatasource: Datasource {
    
    var forecasts = [Forecastday]()

    override func item(_ indexPath: IndexPath) -> Any? {
        return forecasts[indexPath.row]
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [ForecastCell.self]
    }
    
    override func numberOfSections() -> Int {
        return 1
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return forecasts.count
    }
}
