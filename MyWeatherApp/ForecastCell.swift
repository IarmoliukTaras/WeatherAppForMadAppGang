//
//  ForecastCell.swift
//  MyWeatherApp
//
//  Created by 123 on 05.07.17.
//  Copyright © 2017 taras team. All rights reserved.
//

import LBTAComponents

class ForecastCell: DatasourceCell {
    
    override var datasourceItem: Any? {
        didSet {
            guard  let forecast = datasourceItem as? Forecastday else { return }
            dateLabel.text = forecast.date
            minTempLabel.text = String(forecast.mintemp).appending("°")
            maxTempLabel.text = String(forecast.maxtemp).appending("°")
            
            WeatherService.sharedInstance.downloadImage(urlStr: forecast.imageUrl) { (data) in
                let image = UIImage(data: data)
                self.conditionImage.image = image
            }
        }
    }
    
    var conditionImage: UIImageView = {
        let imageView = UIImageView()
//        imageView.backgroundColor = .yellow
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var dateLabel: LBTALabel = {
        let label = LBTALabel(text: "1.01.2017", font: UIFont.boldSystemFont(ofSize: 16))
        label.textAlignment = .center
        return label
    }()
    
    var minTempLabel: LBTALabel = {
        let label = LBTALabel(text: "1.01.2017", font: UIFont.boldSystemFont(ofSize: 16))
        label.textAlignment = .right
        return label
    }()
    
    var maxTempLabel: LBTALabel = {
        let label = LBTALabel(text: "1.01.2017", font: UIFont.boldSystemFont(ofSize: 16))
        label.textAlignment = .left
        
        return label
    }()

    var tempLabel: LBTALabel = {
        let label = LBTALabel(text: "—", font: UIFont.boldSystemFont(ofSize: 16))
        label.textAlignment = .center
        
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .white
        
        
        addSubview(dateLabel)
        dateLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 8, leftConstant: 4, bottomConstant: 0, rightConstant: 4, widthConstant: 0, heightConstant: 20)
        
        let tempStackView = UIStackView(arrangedSubviews: [minTempLabel, tempLabel, maxTempLabel])
        tempStackView.axis = .horizontal
        tempStackView.distribution = .fillEqually
        tempStackView.spacing = 5
        
        addSubview(tempStackView)
        tempStackView.anchor(nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 4, bottomConstant: 4, rightConstant: 4, widthConstant: 0, heightConstant: 20)
        
        addSubview(conditionImage)
        conditionImage.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 32, leftConstant: 10, bottomConstant: 28, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
    }
}
