//
//  SessionViewModel.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 2/25/24.
//

import Foundation
import SwiftData

extension SessionView {
    
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
