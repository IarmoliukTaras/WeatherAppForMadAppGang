//
//  ViewController.swift
//  MyWeatherApp
//
//  Created by 123 on 27.06.17.
//  Copyright © 2017 taras team. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController {
    
    let facebookButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.setImage(#imageLiteral(resourceName: "facebook").withRenderingMode(.alwaysOriginal), for: .normal)
        button.layer.cornerRadius = button.frame.width / 2
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.title = "My Weather App"
        
        setupFacebookButton()
    }
    
    func setupFacebookButton() {
        view.addSubview(facebookButton)
        
        facebookButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        facebookButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        facebookButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        facebookButton.heightAnchor.constraint(equalToConstant: 200).isActive = true
        facebookButton.layer.cornerRadius = 100
        facebookButton.addTarget(self, action: #selector(handleFBLogin), for: .touchUpInside)
    }
    
    func handleFBLogin() {
        FBSDKLoginManager().logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if let err = error {
                print("FB login failed", err)
            }
            print(result?.token.tokenString)
        }
    }

}

