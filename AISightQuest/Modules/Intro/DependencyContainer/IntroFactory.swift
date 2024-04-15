//
//  IntroFactory.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 3/3/24.
//

import SwiftData

typealias IntroFactory = IntroViewFactory

protocol IntroViewFactory {
    func makeIntroView(modelContext: ModelContext) -> IntroView
}
