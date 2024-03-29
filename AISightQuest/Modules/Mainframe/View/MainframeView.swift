//
//  MainframeView.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 2/22/24.
//

import SwiftUI
import SwiftData
import TipKit

// MARK: - Mainframe View

struct MainframeView: View {
    @State private(set) var viewModel: ViewModel
    @EnvironmentObject private var navigationState: NavigationState

    @State private var sessionTapped = 0
    @State private var addSessionButtonTapped = 0
    @State private var isShowingSessionSheet = false
    @State private var index = 0

    var body: some View {
        ZStack {
            MainframeBackgroundView()
            
            Group {
                if viewModel.sessions.isEmpty {
                    VStack {
                        LottieView(name: "Mainframe-Lottie", loopMode: .loop)
                            .aspectRatio(contentMode: .fit)
                            .padding(.horizontal, 20)
                        
                        Spacer()
                    }
                } else {
                    List {
                        ForEach(Array($viewModel.sessions.enumerated()), id: \.element.id) { index, session in
                            Button {
                                self.index = index
                                isShowingSessionSheet = true
                                sessionTapped += 1
                            } label: {
                                SessionRow(session: session)
                            }
                            .listRowBackground(LinearGradient(colors: [Color.darkBlue500,
                                                                       .darkBlue500,
                                                                       .darkBlue600],
                                                              startPoint: .topLeading,
                                                              endPoint: .bottomTrailing).opacity(0.9))
                            .listRowSeparatorTint(Color.lilac400)
                            .sensoryFeedback(.impact(flexibility: .rigid, intensity: 1), trigger: sessionTapped)
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
                }
                
                VStack {
                    Spacer()
                                        
                    Button {
                        withAnimation(.smooth) {
                            viewModel.addSession(name: "New Session", lastChange: Date())
                            addSessionButtonTapped += 1
                        }
                    } label: {
                        HStack {
                            Image(systemName: "plus")
                                .foregroundStyle(.lilac200)
                            Text("new session")
                                .foregroundStyle(.lilac100)
                        }
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding(8)
                        .frame(height: 40)
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
                    .sensoryFeedback(.impact(flexibility: .rigid, intensity: 1), trigger: addSessionButtonTapped)
                    .popoverTip(NewSessionTip())
                    
                    Text("hidden reset button")
                        .foregroundStyle(.clear)
                        .onTapGesture(count: 8) {
                            viewModel.resetApplication()
                        }
                }
                .padding()
            }
            .padding(.horizontal, 16)
        }
        .fullScreenCover(isPresented: $isShowingSessionSheet) {
            MainframeRouter(routes: .session(modelContext: viewModel.modelContext, sessionIndex: index))
                .configure()
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
