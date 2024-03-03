//
//  Routes.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 2/25/24.
//

enum Routes: Equatable, Hashable {
    case splash(SplashRoutes)
    case intro(IntroRoutes)
    case mainframe(MainframeRoutes)
    case session(SessionRoutes)
}
