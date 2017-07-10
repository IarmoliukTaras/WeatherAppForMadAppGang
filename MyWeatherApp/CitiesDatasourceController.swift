
//  CitiesDatasourceController.swift
//  MyWeatherApp
//
//  Created by 123 on 28.06.17.
//  Copyright © 2017 taras team. All rights reserved.
//

import LBTAComponents
import FirebaseDatabase
import FirebaseAuth
import SwiftKeychainWrapper

class CitiesDatasourceController: DatasourceController {
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionViewLayout.invalidateLayout()
    }
    
    let citiesDatasource = CitiesDatasource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.datasource = citiesDatasource
    
        DispatchQueue.global(qos: .background).async {
            DataService.dataService.observeCities() { citiesNames in
                self.citiesDatasource.cities.removeAll()
                
                for name in citiesNames {
                    WeatherService.sharedInstance.getForecast(cityName: name, completion: { (dictionary) in
                        let city = City.init(dictionary: dictionary)
                        self.citiesDatasource.cities.append(city)
                        
                        DispatchQueue.main.async {
                            self.collectionView?.reloadData()
                        }
                    })
                }
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            }
        }
        setupNavigationBarItems()
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCity = citiesDatasource.cities[indexPath.row]
        
        let weatherPageController = ForecastController()
        
        weatherPageController.city = selectedCity
        let navController = UINavigationController(rootViewController: weatherPageController)
        present(navController, animated: false, completion: nil)
    }
    
    func setupNavigationBarItems() {
        navigationItem.title = "Cities"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutPressed))
    }
    
    func logoutPressed() {
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: "uid")
        print(keychainResult)
        try! FIRAuth.auth()?.signOut()
        dismiss(animated: false, completion: nil)
        
    }
    
}
