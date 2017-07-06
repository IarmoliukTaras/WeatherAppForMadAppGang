//
//  Forecast.swift
//  MyWeatherApp
//
//  Created by 123 on 05.07.17.
//  Copyright © 2017 taras team. All rights reserved.
//

import Foundation

struct Forecastday {
    
    var date: String = ""
    var mintemp: Double = 0.0
    var maxtemp: Double = 0.0
    var imageUrl: String = ""
    
    init(forecast: [String: Any]) {
        if let date = forecast["date"] as? String {
            self.date = date
        }
        
        if let day = forecast["day"] as? [String: Any] {
            if let maxtemp = day["maxtemp_c"] as? Double {
                self.maxtemp = maxtemp
            }
            
            if let mintemp = day["mintemp_c"] as? Double {
                self.mintemp = mintemp
            }
            
            if let condition = day["condition"] as? [String: Any] {
                if let imageUrl = condition["icon"] as? String {
                    self.imageUrl = "https:\(imageUrl)"
                }
            }
        }
    }
    
}
