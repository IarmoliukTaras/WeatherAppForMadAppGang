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
    
    typealias DownloadComplete = () -> ()
    
    static let dataService = DataService()
    
    private var _USER_REF = FIRDatabase.database().reference().child("users")
    
    var USER_REF: FIRDatabaseReference {
        return _USER_REF
    }
    
    var CURRENT_USER_REF: FIRDatabaseReference {
        let uid = KeychainWrapper.standard.string(forKey: "uid")
        let user = USER_REF.child(uid!)
        print(uid!)
        return user
    }
    
    var CURRENT_USER_CITIES_REF: FIRDatabaseReference {
        return CURRENT_USER_REF.child("cities")
    }
    
    func addCity(cityName: String) {
        CURRENT_USER_REF.child("cities").updateChildValues([cityName: cityName])
    }
    
    func observeCities(datasource: CitiesDatasource, completed: @escaping DownloadComplete) {
        DataService.dataService.CURRENT_USER_CITIES_REF.observe(.value, with: {(snapshot) in
            var array = [String]()
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    array.append(snap.key)
                }
            }
            datasource.cities = array
            completed()
        })
    }

}
