//
//  StorageManager.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 3/3/24.
//

import Foundation

// MARK: - Storage Manager Protocol

protocol StorageManagerProtocol {
    func getIsFirstOpen() -> Bool
    func setIsFirstOpen(to value: Bool)
}

// MARK: - Storage Manager

final class StorageManager: StorageManagerProtocol, ObservableObject {
    func getIsFirstOpen() -> Bool { !UserDefaults.standard.isFirstOpen }
    func setIsFirstOpen(to value: Bool) { UserDefaults.standard.isFirstOpen = value }
}
