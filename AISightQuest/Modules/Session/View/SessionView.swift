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
    @State private var attributedText = NSAttributedString(string: "")
    
    var body: some View {
        VStack(spacing: 18) {
            TextView(attributedText: $attributedText)
                .padding()
                .background(LinearGradient(colors: [.lilac500, .darkBlue500, .lilac400, .darkBlue600],
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing)
                    .opacity(0.7)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                )
                .padding()
            
            Button {
                isShowingScannerSheet = true
            } label: {
                Label("scan", systemImage: "camera.viewfinder")
                    .foregroundStyle(.darkBlue900)
                    .font(.title2)
            }
            .padding()
            .background(.lilac100)
            .clipShape(RoundedRectangle(cornerRadius: 32))
            .shadow(color: .lilac500,radius: 10)
            .shadow(color: .darkBlue500,radius: 15)
            
            HStack {
                TextField("question text field", text: $questionText)
                    .submitLabel(.search)
                    .padding([.vertical, .leading])
                    .onSubmit {
                        let result = viewModel.findAnswer(for: questionText,
                                                          in: viewModel.sessions[viewModel.sessionIndex].text)
                        
                        if let attributedString = result.attributedText {
                            attributedText = attributedString
                        }
                        questionText = result.questionText
                    }
                
                Button {
                    questionText = ""
                } label: {
                    Image(systemName: "xmark.square")
                        .foregroundStyle(.darkBlue500)
                        .font(.title2)
                        .padding(.trailing)
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.lilac200, lineWidth: 2)
            )
            .padding()
        }
        .onChange(of: attributedText.string) { _, newValue in
            viewModel.sessions[viewModel.sessionIndex].text = newValue
        }
        .onAppear {
            setAttributedText(viewModel.sessions[viewModel.sessionIndex].text)
        }
        .sheet(isPresented: $isShowingScannerSheet) { makeScannerView().ignoresSafeArea() }
    }
    
    private func setAttributedText(_ text: String) {
        attributedText = NSMutableAttributedString(string: text,
                                                   attributes: [.foregroundColor: UIColor.black,
                                                                .font: UIFontMetrics(forTextStyle: .body)
                                                                .scaledFont(for: UIFont.systemFont(ofSize: 17))])
    }
    
    private func makeScannerView() -> ScannerView {
        ScannerView { textPerPage in
            if let text = textPerPage?
                .joined(separator: "\n")
                .trimmingCharacters(in: .whitespacesAndNewlines) {
                setAttributedText(text)
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
