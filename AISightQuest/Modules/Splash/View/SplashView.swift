//
//  SplashView.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 3/3/24.
//

import SwiftUI
import SwiftData

// MARK: - Splash View

struct SplashView: View {
    @State private(set) var viewModel: ViewModel
    @EnvironmentObject private var navigationState: NavigationState
    
    var body: some View {
        Text("Hello, World!")
    }
}

// MARK: - Splash View Preview

#if DEBUG
#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let modelContainer = try! ModelContainer(for: Session.self, configurations: config)
    return SplashView(viewModel: SplashView.ViewModel(modelContext: modelContainer.mainContext, sessionIndex: 1))
}
#endif
