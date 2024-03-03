//
//  SplashDependencyContainer.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 3/3/24.
//

import SwiftData

final class SplashDependencyContainer {
    @MainActor func makeSplashView(modelContext: ModelContext, sessionIndex: Int) -> SplashView {
        SplashView(viewModel: SplashView.ViewModel(modelContext: modelContext))
    }
}
