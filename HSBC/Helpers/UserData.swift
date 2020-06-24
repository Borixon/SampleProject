//
//  UserData.swift
//  HSBC
//
//  Created by Michał Krupa on 24/06/2020.
//  Copyright © 2020 Michał Krupa. All rights reserved.
//

import Foundation

struct UserData {
    
    private let defaults = UserDefaults.standard
    
    private let dataVersionKey = "kDataVersion"
    var version: Float {
        get {
            if let value = defaults.value(forKey: dataVersionKey) as? Float {
                return value
            } else {
                return 0
            }
        }
        set {
            defaults.setValue(newValue, forKey: dataVersionKey)
        }
    }
}
