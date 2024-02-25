//
//  AISightQuestApp.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 2/22/24.
//

import SwiftUI
import SwiftData

@main
struct AISightQuestApp: App {
    @ObservedObject var navigationState = NavigationState()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Session.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationState.routes) {
                MainframeDependencyContainer().makeMainframeView(modelContainer: sharedModelContainer)
                    .navigationDestination(for: AnyHashable.self) { route in
                        if let route = route as? Routes {
                            ViewFactory.viewForDestination(route)
                        }
                    }
            }
            .environmentObject(navigationState)
        }
    }
}
