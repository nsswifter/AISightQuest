//
//  MainframeViewModel.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 2/23/24.
//

import Foundation
import SwiftData

extension MainframeView {
    
    // MARK: - Mainframe View Model
    
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
        
        func addSession(name: String, lastChange: Date) {
            modelContext.insert(Session(name: name, lastChange: lastChange))
            fetchData()
        }
        
        func deleteSession(_ session: Session) {
            modelContext.delete(session)
            fetchData()
        }
        
        func deleteSession(indexSet: IndexSet) {
            indexSet.forEach { index in
                modelContext.delete(sessions[index])
                fetchData()
            }
        }
    }
}
