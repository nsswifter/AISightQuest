//
//  UserDefaults.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 3/3/24.
//

import Foundation

// MARK: - User Defaults Key

enum UserDefaultsKey: String {
    case isFirstOpen = "is_first_open"
}

// MARK: - User Defaults

extension UserDefaults {
    var isFirstOpen: Bool {
        get {
            UserDefaults.standard.bool(forKey: UserDefaultsKey.isFirstOpen.rawValue)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: UserDefaultsKey.isFirstOpen.rawValue)
        }
    }
}
