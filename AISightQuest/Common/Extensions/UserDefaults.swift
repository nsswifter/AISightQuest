//
//  UserDefaults.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 3/3/24.
//

import Foundation

enum UserDefaultsKey: String {
    case isFirstOpen = "is_first_open"
}

extension UserDefaults {
    var isFirstOpen: Bool {
        get {
            return UserDefaults.standard.bool(forKey: UserDefaultsKey.isFirstOpen.rawValue)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: UserDefaultsKey.isFirstOpen.rawValue)
        }
    }
}
