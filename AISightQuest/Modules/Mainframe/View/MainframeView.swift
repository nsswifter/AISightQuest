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
        ZStack {
            MainframeBackgroundView()
            
            Group {
                List {
                    ForEach(Array($viewModel.sessions.enumerated()), id: \.element.id) { index, session in
                        Button {
                            navigationState.routes.append(Routes.mainframe(.session(modelContext: viewModel.modelContext, sessionIndex: index)))
                        } label: {
                            SessionRow(session: session)
                        }
                        .listRowBackground(Color.darkBlue500)
                        .listRowSeparatorTint(Color.lilac400)
                    }
                    .onDelete { indexSet in
                        withAnimation {
                            viewModel.deleteSession(indexSet: indexSet)
                        }
                    }
                }
                .padding(.bottom, 36)
                .scrollIndicators(.never)
                .scrollContentBackground(.hidden)
                .background(.clear)
                
                VStack {
                    Spacer()
                    
                    Text("hidden reset button")
                        .foregroundStyle(.clear)
                        .onTapGesture(count: 8) {
                            viewModel.resetApplication()
                        }
                    
                    Button {
                        viewModel.addSession(name: "New Session", lastChange: Date())
                    } label: {
                        HStack {
                            Image(systemName: "plus")
                                .foregroundStyle(.lilac200)
                            Text("new session")
                                .foregroundStyle(.lilac100)
                        }
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding(16)
                        .background {
                            Capsule()
                                .fill(LinearGradient(colors: [Color.darkBlue500,
                                                              .darkBlue900],
                                                     startPoint: .top,
                                                     endPoint: .bottom))
                        }
                    }
                    .background {
                        Capsule()
                            .fill(.lilac500)
                            .shadow(color: .white, radius: 20, x: 0, y: 0)
                    }
                }
                .padding()
            }
            .padding(.horizontal, 16)
        }
        .navigationBarBackButtonHidden()
    }
}

// MARK: - Mainframe View Preview

#if DEBUG
#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let modelContainer = try! ModelContainer(for: Session.self, configurations: config)
    return MainframeView(viewModel: MainframeView.ViewModel(storageManager: StorageManager(),
                                                            modelContext: modelContainer.mainContext))
}
#endif
