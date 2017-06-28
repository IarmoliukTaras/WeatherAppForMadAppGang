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
    
    private var _USER_REF = FIRDatabase.database().reference().child("user")
    
    var USER_REF: FIRDatabaseReference {
        return _USER_REF
    }
    
    var CURRENT_USER_REF: FIRDatabaseReference {
        let uid = KeychainWrapper.standard.string(forKey: "uid")
        let user = USER_REF.child(uid!)
        return user
    }

}
