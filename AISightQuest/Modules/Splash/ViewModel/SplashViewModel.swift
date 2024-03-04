//
//  SplashViewModel.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 3/3/24.
//

import Foundation
import SwiftData

extension SplashView {
    
    // MARK: - Session View Model
    
    @Observable
    class ViewModel {
        var storageManager: StorageManagerProtocol
        var modelContext: ModelContext
        var sessions: [Session] = []

        init(storageManager: StorageManagerProtocol, modelContext: ModelContext) {
            self.storageManager = storageManager
            self.modelContext = modelContext
            fetchData()
        }
        
        func fetchData() {
            do {
                let descriptor = FetchDescriptor<Session>(sortBy: [SortDescriptor(\.lastChange, order: .reverse)])
                sessions = try modelContext.fetch(descriptor)
            } catch {
                print("Fetch failed")
            }
        }
        
        func getIsFirstOpen() -> Bool {
            storageManager.getIsFirstOpen()
        }
        
        func setIsFirstOpen(to value: Bool) {
            storageManager.setIsFirstOpen(to: value)
        }
    }
}
