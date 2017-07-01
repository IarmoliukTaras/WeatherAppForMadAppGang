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
            guard  let city = datasourceItem as? String else { return }
            nameLabel.text = city
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let dayWeatherLabel: LBTALabel = {
        let label = LBTALabel(text: "Day: 333°", font: UIFont.boldSystemFont(ofSize: 16))
        label.textAlignment = .center
        return label
    }()
    
    let nightWeatherLabel: LBTALabel = {
        let label = LBTALabel(text: "Night: 193°", font: UIFont.boldSystemFont(ofSize: 16))
        label.textAlignment = .center
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
        addSubview(nightWeatherLabel)
        addSubview(removeButton)
        
        nightWeatherLabel.anchor(self.topAnchor, left: nil, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 15, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 0)
        dayWeatherLabel.anchor(self.topAnchor, left: nil, bottom: self.bottomAnchor, right: nightWeatherLabel.leftAnchor, topConstant: 15, leftConstant: 0, bottomConstant: 0, rightConstant: 4, widthConstant: 100, heightConstant: 0)
        nameLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: dayWeatherLabel.leftAnchor, topConstant: 15, leftConstant: 4, bottomConstant: 0, rightConstant: 4, widthConstant: 0, heightConstant: 0)
        removeButton.anchor(self.topAnchor, left: nil, bottom: nightWeatherLabel.topAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 4, widthConstant: 15, heightConstant: 0)
        removeButton.addTarget(self, action: #selector(removeCity), for: .touchUpInside)
    }
    
    func removeCity() {
        DataService.dataService.removeCity(name: nameLabel.text!)
    }
    
}
