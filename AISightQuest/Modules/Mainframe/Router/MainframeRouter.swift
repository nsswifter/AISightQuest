//
//  MainframeRouter.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 2/25/24.
//

import SwiftUI
import SwiftData

enum MainframeRoutes: Hashable {
    case session(modelContext: ModelContext)
}

struct MainframeRouter {
    let routes: MainframeRoutes
    
    @MainActor @ViewBuilder
    func configure() -> some View {
        switch routes {
        case .session(let modelContext):
            SessionDependencyContainer().makeSessionView(modelContext: modelContext)
        }
    }
}
