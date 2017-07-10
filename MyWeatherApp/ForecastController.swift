//
//  ForecastController.swift
//  MyWeatherApp
//
//  Created by 123 on 04.07.17.
//  Copyright © 2017 taras team. All rights reserved.
//

import LBTAComponents
import MapKit

class ForecastController: DatasourceController {
    
    var city: City!
    
    let mapView: MKMapView = {
        let mapView = MKMapView()
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let datasource = ForecastDatasource()
        datasource.forecasts = city.forecastDays
        self.datasource = datasource
        
        view.addSubview(mapView)
        
        collectionView?.alwaysBounceVertical = false
        layout?.scrollDirection = .horizontal
        collectionView?.isPagingEnabled = true
        collectionView?.backgroundColor = .blue
        collectionView?.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 300, leftConstant: 0, bottomConstant: 200, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        automaticallyAdjustsScrollViewInsets = false
        
        navigationItem.title = city.name
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backPressed))
        
        view.addSubview(mapView)
        mapView.anchor(view.topAnchor, left: view.leftAnchor, bottom: collectionView?.topAnchor, right: view.rightAnchor, topConstant: 40, leftConstant: 0, bottomConstant: 4, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        setRegion()
    }
    
    func setRegion() {
        self.mapView.setRegion(MKCoordinateRegion.init(center: CLLocationCoordinate2D.init(latitude: city.lat, longitude: city.lon), span: MKCoordinateSpan.init(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: true)
    }
    
    func backPressed() {
        dismiss(animated: false, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
}
