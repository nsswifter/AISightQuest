//
//  SplashDependencyContainer.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 3/3/24.
//

import SwiftData

final class SplashDependencyContainer: SplashFactory {
    @MainActor func makeSplashView(modelContext: ModelContext) -> SplashView {
        SplashView(viewModel: SplashView.ViewModel(storageManager: StorageManager(),
                                                   modelContext: modelContext))
    }
}
