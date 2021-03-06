//
//  DataService.swift
//  MyWeatherApp
//
//  Created by 123 on 28.06.17.
//  Copyright © 2017 taras team. All rights reserved.
//

import Foundation
import FirebaseDatabase
import SwiftKeychainWrapper

class DataService {
    
    static let dataService = DataService()
    
    private var _USER_REF = FIRDatabase.database().reference().child("users")
    
    var USER_REF: FIRDatabaseReference {
        return _USER_REF
    }
    
    var CURRENT_USER_REF: FIRDatabaseReference {
        let uid = KeychainWrapper.standard.string(forKey: "uid")
        let user = USER_REF.child(uid!)
        return user
    }
    
    var CURRENT_USER_CITIES_REF: FIRDatabaseReference {
        return CURRENT_USER_REF.child("cities")
    }
    
    func addCity(cityName: String) {
        CURRENT_USER_REF.child("cities").updateChildValues([cityName: cityName])
    }
    
    func observeCities(completed: @escaping ([String]) -> ()) {
        DataService.dataService.CURRENT_USER_CITIES_REF.observe(.value, with: {(snapshot) in
            guard let dataSnapshot = snapshot.children.allObjects as? [FIRDataSnapshot] else { return }
            completed(dataSnapshot.map{$0.key})
        })
    }
    
    func removeCity(name: String) {
        DataService.dataService.CURRENT_USER_CITIES_REF.child(name).removeValue()
    }

}
