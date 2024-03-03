//
//  MainframeView.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 2/22/24.
//

import SwiftUI
import SwiftData

// MARK: - Mainframe View

struct MainframeView: View {
    @State private(set) var viewModel: ViewModel
    @EnvironmentObject private var navigationState: NavigationState

    var body: some View {
        List {
            ForEach(Array($viewModel.sessions.enumerated()), id: \.element.id) { index, session in
                Button {
                    navigationState.routes.append(Routes.mainframe(.session(modelContext: viewModel.modelContext, sessionIndex: index)))
                } label: {
                    SessionRow(session: session)
                }
            }
            .onDelete { indexSet in
                withAnimation {
                    viewModel.deleteSession(indexSet: indexSet)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.addSession(name: "New Session", lastChange: Date())
                } label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("New Session")
                    }
                    .foregroundStyle(.darkBlue500)
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

// MARK: - Mainframe View Preview

#if DEBUG
#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let modelContainer = try! ModelContainer(for: Session.self, configurations: config)
    return MainframeView(viewModel: MainframeView.ViewModel(modelContext: modelContainer.mainContext))
}
#endif
