//
//  City.swift
//  MyWeatherApp
//
//  Created by 123 on 03.07.17.
//  Copyright © 2017 taras team. All rights reserved.
//

import Foundation

class City {
    
    private var _name: String!
    private var _temp: Double!
    private var _condition: String!
    
    var name: String {
        if _name == nil {
            _name = ""
        }
        return _name
    }
    
    var temp: Double {
        if _temp == nil {
            _temp = 0
        }
        return _temp
    }
    
    var condition: String {
        if _condition == nil {
            _condition = ""
        }
        return _condition
    }
    
    init(weatherDic: [String: Any]) {
        if let locationDictionary = weatherDic["location"] as? [String: Any] {
            if let name = locationDictionary["name"] as? String {
                self._name = name
            }
        }
        
        if let currentDictionary = weatherDic["current"] as? [String: Any] {
            if let temp = currentDictionary["temp_c"] as? Double {
                self._temp = temp
            }
            
            if let conditionDictionary = currentDictionary["condition"] as? [String: Any] {
                if let condition = conditionDictionary["text"] as? String {
                    self._condition = condition
                }
            }
        }
    }
}
