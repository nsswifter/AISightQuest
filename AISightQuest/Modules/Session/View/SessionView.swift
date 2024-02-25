//
//  SessionView.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 2/25/24.
//

import SwiftUI
import SwiftData

// MARK: - Session View

struct SessionView: View {
    @State private(set) var viewModel: ViewModel
    @EnvironmentObject private var navigationState: NavigationState
    
    @State private var isShowingScannerSheet = false
    @State private var questionText = ""
    
    var body: some View {
        VStack(spacing: 32) {
            TextEditor(text: $viewModel.sessions[viewModel.sessionIndex].text)
                .padding()
                .frame(maxHeight: 500)
            
            Button {
                isShowingScannerSheet = true
            } label: {
                Label("Scan", systemImage: "camera")
                    .foregroundColor(.black)
                    .font(.title2)
            }
            .padding(8)
            .background(.lilac400)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            
            TextField("Question Text Field", text: $questionText)
                .padding()
        }
        .sheet(isPresented: $isShowingScannerSheet) { makeScannerView().ignoresSafeArea() }
    }
     
    private func makeScannerView() -> ScannerView {
        ScannerView { textPerPage in
            if let text = textPerPage?
                .joined(separator: "\n")
                .trimmingCharacters(in: .whitespacesAndNewlines) {
                viewModel.sessions[viewModel.sessionIndex].text = text
            }
            isShowingScannerSheet = false
        }
    }
}

// MARK: - Session View Preview

#if DEBUG
#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let modelContainer = try! ModelContainer(for: Session.self, configurations: config)
    return SessionView(viewModel: SessionView.ViewModel(modelContext: modelContainer.mainContext, sessionIndex: 1))
}
#endif
