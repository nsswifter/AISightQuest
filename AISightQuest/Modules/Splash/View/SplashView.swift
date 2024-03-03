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
        LottieView(name: "AI-Sight-Quest-Lottie")
            .frame(width: 250, height: 250)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline:.now() + 3) {
                    withAnimation(.easeOut(duration: 0.5)) {
                        if viewModel.isFirstTimeOpen {
                            viewModel.isFirstTimeOpen = false
                            navigationState.routes.append(Routes.splash(.intro(modelContext: viewModel.modelContext)))
                        } else {
                            navigationState.routes.append(Routes.splash(.mainframe(modelContext: viewModel.modelContext)))
                        }
                    }
                }
            }
    }
}

// MARK: - Splash View Preview

#if DEBUG
#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let modelContainer = try! ModelContainer(for: Session.self, configurations: config)
    return SplashView(viewModel: SplashView.ViewModel(modelContext: modelContainer.mainContext))
}
#endif
