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
        label.backgroundColor = .red
        return label
    }()
    
    let dayWeatherLabel: LBTALabel = {
        let label = LBTALabel(text: "Day: 333°", font: UIFont.boldSystemFont(ofSize: 16))
        label.backgroundColor = .blue
        label.textAlignment = .center
        return label
    }()
    
    let nightWeatherLabel: LBTALabel = {
        let label = LBTALabel(text: "Night: 193°", font: UIFont.boldSystemFont(ofSize: 16))
        label.backgroundColor = .green
        label.textAlignment = .center
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(nameLabel)
        addSubview(dayWeatherLabel)
        addSubview(nightWeatherLabel)
        
        nightWeatherLabel.anchor(self.topAnchor, left: nil, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 0)
        dayWeatherLabel.anchor(self.topAnchor, left: nil, bottom: self.bottomAnchor, right: nightWeatherLabel.leftAnchor, topConstant: 4, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 100, heightConstant: 0)
        nameLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: dayWeatherLabel.leftAnchor, topConstant: 4, leftConstant: 4, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
    }
    
}
