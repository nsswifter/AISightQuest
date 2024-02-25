//
//  SessionDependencyContainer.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 2/25/24.
//

import SwiftData

final class SessionDependencyContainer {
    @MainActor func makeSessionView(modelContext: ModelContext, sessionIndex: Int) -> SessionView {
        SessionView(viewModel: SessionView.ViewModel(modelContext: modelContext, sessionIndex: sessionIndex))
    }
}
