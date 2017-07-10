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
    private var _lat: Double!
    private var _lon: Double!
    private var _temp: Double!
    private var _condition: String!
    
    private var _forecastDays: [Forecastday]!
    
    var name: String {
        if _name == nil {
            _name = ""
        }
        return _name
    }
    
    var lat: Double {
        if _lat == nil {
            _lat = 0.0
        }
        return _lat
    }
    
    var lon: Double {
        if _lon == nil {
            _lon = 0.0
        }
        return _lon
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
    
    var forecastDays: [Forecastday] {
        if _forecastDays == nil {
            _forecastDays = [Forecastday]()
        }
        return _forecastDays
    }
    
    init(dictionary: [String: Any]) {
        self.setLocation(dictionary: dictionary)
        
        self.setCurrentWeather(dictionary: dictionary)
        
        self.setForecast(dictionary: dictionary)
    }
    
    func setLocation(dictionary: [String: Any]) {
        if let locationDictionary = dictionary["location"] as? [String: Any] {
            if let name = locationDictionary["name"] as? String {
                self._name = name
            }
            
            if let lat = locationDictionary["lat"] as? Double {
                self._lat = lat
            }
            
            if let lon = locationDictionary["lon"] as? Double {
                self._lon = lon
            }
        }
    }
    
    func setCurrentWeather(dictionary: [String: Any]) {
        if let currentDictionary = dictionary["current"] as? [String: Any] {
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
    
    func setForecast(dictionary: [String: Any]) {
        guard let forecastDic = dictionary["forecast"] as? [String: Any] else { return }
        if let forecastdays = forecastDic["forecastday"] as? [[String: Any]] {
            self._forecastDays = forecastdays.map{Forecastday(forecast: $0)}
        }
    }
}
