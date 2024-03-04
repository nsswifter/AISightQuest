//
//  SplashRouter.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 3/3/24.
//

import SwiftUI
import SwiftData

enum SplashRoutes: Hashable { 
    case intro(modelContext: ModelContext)
    case mainframe(modelContext: ModelContext)
}

struct SplashRouter {
    let routes: SplashRoutes
    
    @MainActor @ViewBuilder
    func configure() -> some View {
        switch routes {
        case .intro(let modelContext):
            IntroDependencyContainer().makeIntroView(modelContext: modelContext)
        case .mainframe(let modelContext):
            MainframeDependencyContainer().makeMainframeView(modelContext: modelContext)
        }
    }
}
