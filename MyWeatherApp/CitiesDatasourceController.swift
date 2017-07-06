//
//  CitiesDatasourceController.swift
//  MyWeatherApp
//
//  Created by 123 on 28.06.17.
//  Copyright © 2017 taras team. All rights reserved.
//

import LBTAComponents
import FirebaseDatabase

class CitiesDatasourceController: DatasourceController {
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionViewLayout.invalidateLayout()
    }
    
    var citiesName = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let datasource = CitiesDatasource()
        self.datasource = datasource
        
        DataService.dataService.observeCities() { citiesNames in
            self.citiesName = citiesNames
            datasource.citiesNames = citiesNames
            self.collectionView?.reloadData()
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
        let selectedCity = self.citiesName[indexPath.row]
        
        let weatherPageController = ForecastController()
        
        weatherPageController.cityName = selectedCity
        let navController = UINavigationController(rootViewController: weatherPageController)
        present(navController, animated: false, completion: nil)
    }
    
    func setupNavigationBarItems() {
        navigationItem.title = "Cities"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(menuPressed))
    }
    
    func menuPressed() {
        print("menu pressed")
        
    }
    
}
