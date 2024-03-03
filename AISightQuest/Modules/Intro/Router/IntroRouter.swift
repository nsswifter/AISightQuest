//
//  IntroRouter.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 3/3/24.
//

import SwiftUI

enum IntroRoutes: Hashable { }

struct IntroRouter {
    let routes: IntroRoutes
    
    @MainActor @ViewBuilder
    func configure() -> some View {
        switch routes {
        default:
            EmptyView()
        }
    }
}
