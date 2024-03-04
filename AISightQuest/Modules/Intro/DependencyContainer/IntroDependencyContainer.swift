//
//  IntroDependencyContainer.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 3/3/24.
//

import SwiftData

final class IntroDependencyContainer {
    @MainActor func makeIntroView(modelContext: ModelContext) -> IntroView {
        IntroView(viewModel: IntroView.ViewModel(storageManager: StorageManager(),
                                                 modelContext: modelContext))
    }
}
