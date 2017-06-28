//
//  SignInViewController.swift
//  MyWeatherApp
//
//  Created by 123 on 27.06.17.
//  Copyright © 2017 taras team. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth
import SwiftKeychainWrapper


class SignInViewController: UIViewController {
    
    let facebookButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.setImage(#imageLiteral(resourceName: "facebook").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Please, login with Facebook"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .blue 
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "My Weather App"
        
        setupFacebookButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: "uid"){
            let navController = UINavigationController(rootViewController: CitiesDatasourceController())
            present(navController, animated: true, completion: nil)
        }
    }
    
    func setupFacebookButton() {
        view.addSubview(facebookButton)
        facebookButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        facebookButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        facebookButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        facebookButton.heightAnchor.constraint(equalToConstant: 200).isActive = true
        facebookButton.layer.cornerRadius = 100
        facebookButton.addTarget(self, action: #selector(handleFBLogin), for: .touchUpInside)
        
        view.addSubview(infoLabel)
        infoLabel.bottomAnchor.constraint(equalTo: facebookButton.topAnchor, constant: -20).isActive = true
        infoLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        infoLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func handleFBLogin() {
        FBSDKLoginManager().logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if let err = error {
                print("LOG: FB login failed", err)
            } else if result?.isCancelled == true {
                print("LOG: User cancelled FB authenticate")
            } else {
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
                    if let err = error {
                        print("LOG: Unable to authenticate with Firebase", err)
                    } else {
                        print("LOG: Successfully authenticated with Firebase")
                        if let user = user {
                            self.completeSignIn(id: user.uid)
                        }
                    }
                })
            }
        }
    }
    
    func completeSignIn(id: String) {
        KeychainWrapper.standard.set(id, forKey: "uid")
        let navController = UINavigationController(rootViewController: CitiesDatasourceController())
        present(navController, animated: true, completion: nil)
    }

}

