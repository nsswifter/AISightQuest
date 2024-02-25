//
//  MainframeDependencyContainer.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 2/25/24.
//

import SwiftData

final class MainframeDependencyContainer {
    @MainActor func makeMainframeView(modelContext: ModelContext) -> MainframeView {
        MainframeView(viewModel: MainframeView.ViewModel(modelContext: modelContext))
    }
}
