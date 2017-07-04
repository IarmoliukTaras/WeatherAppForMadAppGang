//
//  WeatherService.swift
//  MyWeatherApp
//
//  Created by 123 on 01.07.17.
//  Copyright © 2017 taras team. All rights reserved.
//

import Foundation

class WeatherService {
    
    static let sharedInstance = WeatherService()
    
    let url = "https://api.apixu.com/v1/current.json?key=02e91a4d2b4b447d82a164332170107&q="
    
    func getCurrentWeather(cityName: String, completion: @escaping ([String: Any]) -> Void) {
        let fullUrl = self.getFullUrl(cityName: cityName)
        guard let url = URL(string: fullUrl) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let err = error {
                print("ERROR:", err)
                return
            }
            
            guard let resp = response as? HTTPURLResponse else { return }
            if resp.statusCode == 400 {
                DataService.dataService.removeCity(name: cityName)
                return
            }
            
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                guard let infoDictionary = json as? [String: Any] else { return }
                
                DispatchQueue.main.async {
                    completion(infoDictionary)
                }
                
            } catch let jsonError {
                print(jsonError)
            }
            
        }).resume()
    }
    
    func getFullUrl(cityName: String) -> String {
        return url.appending(cityName.lowercased())
    }
    
    func checkCity(name: String, completion: @escaping (Bool) -> Void) {
        let fullUrl = self.getFullUrl(cityName: name)
        var answer = true
        guard let url = URL(string: fullUrl) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let err = error {
                print("ERROR:", err)
                return
            }
            
            guard let resp = response as? HTTPURLResponse else { return }
            if resp.statusCode == 400 {
                answer = false
            }
            DispatchQueue.main.async {
                completion(answer)
            }
        }).resume()
    }
}
