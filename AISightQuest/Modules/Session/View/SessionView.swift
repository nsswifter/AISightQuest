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
    @Environment(\.dismiss) private var dismiss
    @State private(set) var viewModel: ViewModel
    @EnvironmentObject private var navigationState: NavigationState
    
    @State private var isShowingScannerSheet = false
    @State private var clearAttributedTextButtonTapped = 0
    @State private var clearQuestionButtonTapped = 0
    @State private var dismissButtonTapped = 0
    @State private var dismissButtonOffset = -100.0

    @State private var questionText = ""
    @State private var attributedText = NSAttributedString(string: "")
    
    var body: some View {
        VStack(spacing: 8) {
            Button {
                dismiss()
                dismissButtonTapped += 1
            } label: {
                HStack {
                    Image(systemName: "arrowshape.turn.up.backward.fill")
                        .rotationEffect(.degrees(90))
                        .scaleEffect(x: -1, y: 1)
                        .bold()
                    
                    Text("back")
                    
                    Spacer()
                }
                .foregroundStyle(.darkBlue500)
                .padding(.leading)
            }
            .offset(x: dismissButtonOffset)
            .onAppear {
                withAnimation(.bouncy(duration: 1)) {
                    dismissButtonOffset = 0
                }
            }
            .sensoryFeedback(.impact(flexibility: .rigid, intensity: 1),
                             trigger: dismissButtonTapped)
            
            TextView(attributedText: $attributedText)
                .padding()
                .padding(.bottom, 52)
                .background {
                    LinearGradient(colors: [.darkBlue300, .lilac100,
                                            .darkBlue300, .lilac200],
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                }
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .padding()
                .overlay {
                    VStack {
                        Spacer()
                        
                        HStack {
                            Spacer()
                            
                            Button {
                                isShowingScannerSheet = true
                            } label: {
                                HStack {
                                    Image(systemName: "camera.circle.fill")
                                        .foregroundStyle(.lilac200)
                                        .font(.title2)
                                    Text("scan")
                                        .foregroundStyle(.lilac100)
                                }
                                .padding()
                            }
                            .buttonStyle(CustomButtonStyle())
                            .sensoryFeedback(.impact(flexibility: .rigid, intensity: 1),
                                             trigger: isShowingScannerSheet)
                            .popoverTip(ScanDocumentTip())
                            
                            Button {
                                setAttributedText("")
                                clearAttributedTextButtonTapped += 1
                            } label: {
                                Image(systemName: "xmark")
                                    .foregroundStyle(.lilac200)
                            }
                            .buttonStyle(CustomButtonStyle())
                            .hidden(attributedText.string.isEmpty, remove: attributedText.string.isEmpty)
                            .sensoryFeedback(.impact(flexibility: .rigid, intensity: 1),
                                             trigger: clearAttributedTextButtonTapped)
                        }
                    }
                    .padding(28)
                    .padding(.vertical, 4)
                }
            
            HStack {
                TextField("question text field", text: $questionText.animation(.bouncy(duration: 1)))
                    .tint(.lilac400)
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
                    clearQuestionButtonTapped += 1
                } label: {
                    Image(systemName: "xmark.circle")
                        .foregroundStyle(.darkBlue500)
                        .font(.title)
                        .padding(.trailing)
                }
                .hidden(questionText.isEmpty, remove: questionText.isEmpty)
                .sensoryFeedback(.impact(flexibility: .rigid, intensity: 1),
                                 trigger: clearQuestionButtonTapped)
            }
            .overlay(
                Capsule()
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
        withAnimation(.bouncy(duration: 1)) {
            attributedText = NSMutableAttributedString(string: text,
                                                       attributes: [.foregroundColor: UIColor.black,
                                                                    .font: UIFontMetrics(forTextStyle: .body)
                                                                    .scaledFont(for: UIFont.systemFont(ofSize: 17))])
        }
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
