//
//  CityHeader.swift
//  MyWeatherApp
//
//  Created by 123 on 01.07.17.
//  Copyright © 2017 taras team. All rights reserved.
//

import LBTAComponents

class CityHeader: DatasourceCell {
    
    let cityNameTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.placeholder = " Enter city's name..."
        return textField
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("ADD", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    override func setupViews() {
        super.setupViews()

        
        addSubview(cityNameTextField)
        cityNameTextField.anchor(nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 4, bottomConstant: 2, rightConstant: 100, widthConstant: 0, heightConstant: 40)
        addSubview(addButton)
        addButton.anchor(nil, left: cityNameTextField.rightAnchor, bottom: cityNameTextField.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 4, bottomConstant: 0, rightConstant: 4, widthConstant: 0, heightConstant: 40)
        addButton.addTarget(self, action: #selector(addPressed), for: .touchUpInside)
    }
    
    func addPressed() {
        guard let city = cityNameTextField.text else { return }
        WeatherService.sharedInstance.checkCity(name: city) { (answer) in
            if answer == true {
                DataService.dataService.addCity(cityName: city)
            }
        }
        cityNameTextField.text = ""
    }
}
