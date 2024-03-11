//
//  IntroRouter.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 3/3/24.
//

import SwiftUI
import SwiftData

enum IntroRoutes: Hashable { 
    case mainframe(modelContext: ModelContext)
}

struct IntroRouter {
    let routes: IntroRoutes
    
    @MainActor @ViewBuilder
    func configure() -> some View {
        switch routes {
        case .mainframe(let modelContext):
            MainframeDependencyContainer().makeMainframeView(modelContext: modelContext)
        }
    }
}
