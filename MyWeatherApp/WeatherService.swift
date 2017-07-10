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
    
    private let session = URLSession.shared
    
    func getForecast(cityName: String, completion: @escaping ([String: Any]) -> Void) {
        let forecastUrl = "https://api.apixu.com/v1/forecast.json?key=02e91a4d2b4b447d82a164332170107&q=\(cityName)&days=10"
        guard let url = URL(string: forecastUrl) else { return }
        session.dataTask(with: url, completionHandler: { (data, response, error) in
            if let err = error {
                print("ERROR:", err)
                return
            }
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                guard let forecastDic = json as? [String: Any] else { return }
                completion(forecastDic)
                
            } catch let jsonError {
                print(jsonError)
            }
        }).resume()
    }

    func checkCity(name: String, completion: @escaping (Bool) -> Void) {
        let fullUrl = "https://api.apixu.com/v1/current.json?key=02e91a4d2b4b447d82a164332170107&q=".appending(name.lowercased())
        var answer = true
        guard let url = URL(string: fullUrl) else { return }
        session.dataTask(with: url, completionHandler: { (data, response, error) in
            if let err = error {
                print("ERROR:", err)
                return
            }
            
            guard let resp = response as? HTTPURLResponse else { return }
            if resp.statusCode == 400 {
                answer = false
            }
            completion(answer)
        }).resume()
    }
    
    func downloadImage(urlStr: String, completion: @escaping (Data) -> Void) {
        guard let url = URL(string: urlStr) else { return }
        
        session.dataTask(with: url, completionHandler: { (data, response, error) in
            if let err = error {
                print("ERROR:", err)
                return
            }
            guard let data = data else { return }
            completion(data)
        }).resume()
    }
}
