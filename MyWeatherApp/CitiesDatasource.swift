//
//  CitiesDatasource.swift
//  MyWeatherApp
//
//  Created by 123 on 28.06.17.
//  Copyright © 2017 taras team. All rights reserved.
//

import LBTAComponents
import FirebaseDatabase

class CitiesDatasource: Datasource {
    
    var cities = [String]()
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return cities[indexPath.row]
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [CityCell.self]
    }
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [CityHeader.self]
    }
    
    override func numberOfSections() -> Int {
        return 1
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return cities.count
    }
}
