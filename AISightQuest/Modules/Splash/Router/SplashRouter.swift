//
//  SplashRouter.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 3/3/24.
//

import SwiftUI

enum SplashRoutes: Hashable { }

struct SplashRouter {
    let routes: SplashRoutes
    
    @MainActor @ViewBuilder
    func configure() -> some View {
        switch routes {
        default:
            EmptyView()
        }
    }
}
