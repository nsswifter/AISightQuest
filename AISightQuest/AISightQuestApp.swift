//
//  AISightQuestApp.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 2/22/24.
//

import SwiftUI
import SwiftData
import TipKit

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
                SplashDependencyContainer().makeSplashView(modelContext: sharedModelContainer.mainContext)
                    .navigationDestination(for: AnyHashable.self) { route in
                        if let route = route as? Routes {
                            ViewFactory.viewForDestination(route)
                        }
                    }
            }
            .task {
                try? Tips.configure([
                    .displayFrequency(.immediate),
                    .datastoreLocation(.applicationDefault)
                ])
                
                // Set the default tint color for tips on the popover
                UIView.appearance(whenContainedInInstancesOf: [TipUIPopoverViewController.self]).tintColor = .darkBlue300
            }
            .environmentObject(navigationState)
        }
    }
}
