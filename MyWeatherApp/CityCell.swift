//
//  CityCell.swift
//  MyWeatherApp
//
//  Created by 123 on 28.06.17.
//  Copyright © 2017 taras team. All rights reserved.
//

import LBTAComponents

class CityCell: DatasourceCell {
    
    override var datasourceItem: Any? {
        didSet {
            guard let city = datasourceItem as? City else { return }
            self.nameLabel.text = city.name
            self.dayWeatherLabel.text = String(city.temp).appending("°")
            self.conditionLabel.text = city.condition
        }
    }
    
    let nameLabel: LBTALabel = {
        let label = LBTALabel(text: "", font: UIFont.boldSystemFont(ofSize: 16))
        return label
    }()

    let dayWeatherLabel: LBTALabel = {
        let label = LBTALabel(text: "", font: UIFont.boldSystemFont(ofSize: 16))
        label.textAlignment = .center
        return label
    }()
    
    let conditionLabel: LBTALabel = {
        let label = LBTALabel(text: "", font: UIFont.boldSystemFont(ofSize: 16))
        label.numberOfLines = 0
        return label
    }()
    
    let removeButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "close").withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        
        return button
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(nameLabel)
        addSubview(dayWeatherLabel)
        addSubview(conditionLabel)
        addSubview(removeButton)
        
        conditionLabel.anchor(self.topAnchor, left: nil, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 15, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 150, heightConstant: 0)
        dayWeatherLabel.anchor(self.topAnchor, left: nil, bottom: self.bottomAnchor, right: conditionLabel.leftAnchor, topConstant: 15, leftConstant: 0, bottomConstant: 0, rightConstant: 4, widthConstant: 100, heightConstant: 0)
        nameLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: dayWeatherLabel.leftAnchor, topConstant: 15, leftConstant: 4, bottomConstant: 0, rightConstant: 4, widthConstant: 0, heightConstant: 0)
        removeButton.anchor(self.topAnchor, left: nil, bottom: conditionLabel.topAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 4, widthConstant: 15, heightConstant: 0)
        removeButton.addTarget(self, action: #selector(removeCity), for: .touchUpInside)
    }
    
    func removeCity() {
        guard let city = datasourceItem as? City else { return }
        DataService.dataService.removeCity(name: city.name)
    }
    
}
