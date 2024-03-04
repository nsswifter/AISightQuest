//
//  ViewFactory.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 2/25/24.
//

import SwiftUI

@MainActor class ViewFactory {
    
    @ViewBuilder
    static func viewForDestination(_ destination: Routes) -> some View {
        switch destination {
        case .splash(let routes):
            SplashRouter(routes: routes).configure()
        case .intro(let routes):
            IntroRouter(routes: routes).configure()
        case .mainframe(let routes):
            MainframeRouter(routes: routes).configure()
        case .session(let routes):
            SessionRouter(routes: routes).configure()
        }
    }
}
