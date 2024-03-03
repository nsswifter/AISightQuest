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
        var modelContext: ModelContext
        var sessions: [Session] = []
        var isFirstTimeOpen = true

        init(modelContext: ModelContext) {
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
    }
}
