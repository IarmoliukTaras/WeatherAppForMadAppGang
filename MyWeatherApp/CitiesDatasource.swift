//
//  CitiesDatasource.swift
//  MyWeatherApp
//
//  Created by 123 on 28.06.17.
//  Copyright © 2017 taras team. All rights reserved.
//

import LBTAComponents

class CitiesDatasource: Datasource {
    override func cellClasses() -> [DatasourceCell.Type] {
        return [CityCell.self]
    }
    
    override func numberOfSections() -> Int {
        return 1
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return 2
    }
    
}
