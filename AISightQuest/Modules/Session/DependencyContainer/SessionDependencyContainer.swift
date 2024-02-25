//
//  SessionDependencyContainer.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 2/25/24.
//

import SwiftData

final class SessionDependencyContainer {
    @MainActor func makeSessionView(modelContainer: ModelContainer) -> MainframeView {
        MainframeView(viewModel: MainframeView.ViewModel(modelContext: modelContainer.mainContext))
    }
}
