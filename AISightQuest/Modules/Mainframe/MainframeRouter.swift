//
//  MainframeRouter.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 2/25/24.
//

import SwiftUI

enum MainframeRoutes: Hashable {
    case session
}

struct MainframeRouter {
    let routes: MainframeRoutes
    
    @MainActor @ViewBuilder
    func configure() -> some View {
        switch routes {
        case .session:
            EmptyView()
        }
    }
}
