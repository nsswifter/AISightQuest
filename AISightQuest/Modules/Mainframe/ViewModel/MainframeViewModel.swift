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
        private var storageManager: StorageManagerProtocol
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
        
        func renameSession(currentName: String, into desiredName: String) -> String {
            var newName = desiredName
            
            if newName.isEmpty { newName = "New Session" }
            
            var count = 2
            while sessions.contains(where: { $0.name == newName }) {
                newName = "\(desiredName.isEmpty ? "New Session" : desiredName) \(count)"
                count += 1
            }
            
            return newName
        }
        
        func updateSession(sessionIndex: Int, name: String, lastChange: Date) {
            sessions[sessionIndex].name = name
            sessions[sessionIndex].lastChange = lastChange
            
            fetchData()
        }
        
        func addSession(name: String, lastChange: Date) {
            var newName = name
            var count = 2
            
            while sessions.contains(where: { $0.name == newName }) {
                newName = "\(name) \(count)"
                count += 1
            }
            
            modelContext.insert(Session(name: newName, lastChange: lastChange))
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
        
        func deleteAllSessions() {
            for session in sessions {
                modelContext.delete(session)
            }
            fetchData()
        }
        
        var isFirstOpen: Bool {
            get {
                storageManager.getIsFirstOpen()
            }
            set {
                storageManager.setIsFirstOpen(to: newValue)
            }
        }
        
        func resetApplication() {
            deleteAllSessions()
            isFirstOpen = false
        }
    }
}
