//
//  IntroView.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 3/3/24.
//

import SwiftUI
import SwiftData

// MARK: - Intro View

struct IntroView: View {
    @State private(set) var viewModel: ViewModel
    @EnvironmentObject private var navigationState: NavigationState

    var body: some View {
        Text("Hello, World!")
            .navigationBarBackButtonHidden()
    }
}

// MARK: - Intro View Preview

#if DEBUG
#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let modelContainer = try! ModelContainer(for: Session.self, configurations: config)
    return IntroView(viewModel: IntroView.ViewModel(storageManager: StorageManager(),
                                                    modelContext: modelContainer.mainContext))
}
#endif
