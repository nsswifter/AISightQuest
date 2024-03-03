//
//  IntroViewModel.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 3/3/24.
//

import Foundation
import SwiftData

extension IntroView {
    
    // MARK: - Session View Model
    
    @Observable
    class ViewModel {
        var modelContext: ModelContext
        let sessionIndex: Int
        var sessions: [Session] = []

        init(modelContext: ModelContext, sessionIndex: Int) {
            self.modelContext = modelContext
            self.sessionIndex = sessionIndex
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
