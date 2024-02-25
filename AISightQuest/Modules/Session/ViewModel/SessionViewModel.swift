//
//  SessionViewModel.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 2/25/24.
//

import Foundation

import Foundation
import SwiftData

extension SessionView {
    
    // MARK: - Session View Model
    
    @Observable
    class ViewModel {
        var modelContext: ModelContext
        var sessions: [Session] = []

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
