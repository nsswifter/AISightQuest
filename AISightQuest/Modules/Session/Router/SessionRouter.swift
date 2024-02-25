//
//  SessionRouter.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 2/25/24.
//

import SwiftUI

enum SessionRoutes: Hashable { }

struct SessionRouter {
    let routes: SessionRoutes
    
    @MainActor @ViewBuilder
    func configure() -> some View {
        switch routes {
        default:
            EmptyView()
        }
    }
}
