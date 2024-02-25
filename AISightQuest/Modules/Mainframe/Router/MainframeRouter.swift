//
//  MainframeRouter.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 2/25/24.
//

import SwiftUI
import SwiftData

enum MainframeRoutes: Hashable {
    case session(modelContext: ModelContext, sessionIndex: Int)
}

struct MainframeRouter {
    let routes: MainframeRoutes
    
    @MainActor @ViewBuilder
    func configure() -> some View {
        switch routes {
        case .session(let modelContext, let sessionIndex):
            SessionDependencyContainer().makeSessionView(modelContext: modelContext, sessionIndex: sessionIndex)
        }
    }
}
