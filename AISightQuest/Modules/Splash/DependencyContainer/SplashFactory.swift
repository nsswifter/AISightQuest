//
//  SplashFactory.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 3/3/24.
//

import SwiftData

typealias SplashFactory = SplashViewFactory

protocol SplashViewFactory {
    func makeSplashView(modelContainer: ModelContainer) -> SplashView
}
