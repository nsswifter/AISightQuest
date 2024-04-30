//
//  SessionView.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 2/25/24.
//

import SwiftUI
import SwiftData
import PhotosUI

// MARK: - Session View

struct SessionView: View {
    @State private(set) var viewModel: ViewModel
    @EnvironmentObject private var navigationState: NavigationState
    
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    
    @State private var onAppearUpdatedAttributedText = false
    @State private var isShowingScannerSheet = false
    @State private var micButtonTapped = 0
    @State private var clearAttributedTextButtonTapped = 0
    @State private var clearQuestionButtonTapped = 0
    @State private var submitQuestionButtonTapped = 0
    @State private var dismissButtonTapped = 0
    @State private var dismissButtonOffset = -100.0
    
    @State private var questionText = ""
    @State private var attributedText = NSAttributedString()
    
    @State private var selectedItem: PhotosPickerItem?
    
    var body: some View {
        VStack {
            Button {
                dismiss()
                dismissButtonTapped += 1
            } label: {
                HStack {
                    Image(systemName: "arrowshape.turn.up.backward.fill")
                        .bold()
                    
                    Spacer()
                }
                .foregroundStyle(.darkBlue500)
                .padding(.top)
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
                    ZStack {
                        LinearGradient(colors: [.darkBlue300, .lilac100,
                                                .darkBlue300, .lilac200],
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing)
                        
                        VStack {
                            Spacer()
                            
                            CustomProgressView(progress: viewModel.playingProgress,
                                               height: 5,
                                               progressColor: .darkBlue500,
                                               backgroundColor: .clear)
                        }
                        .padding(.horizontal, 20)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 36))
                .padding(.vertical)
                .overlay {
                    VStack {
                        Spacer()
                        
                        Stack(orientation: attributedText.isEmpty ? .vertical : .horizontal) {
                            Button {
                                print("Document Scanner Pressed")
                                isShowingScannerSheet = true
                            } label: {
                                HStack {
                                    Image(systemName: "camera")
                                        .foregroundStyle(.lilac200)
                                        .font(.title2)
                                        .fontWeight(.regular)
                                    
                                    Text("scan")
                                        .foregroundStyle(.lilac100)
                                        .hidden(!attributedText.isEmpty, remove: !attributedText.isEmpty)
                                }
                                .padding(shouldAddPadding: attributedText.isEmpty)
                            }
                            .buttonStyle(CustomButtonStyle())
                            .sensoryFeedback(.impact(flexibility: .rigid, intensity: 1),
                                             trigger: isShowingScannerSheet)
                            .popoverTip(ScanDocumentTip())
                            
                            PhotosPicker(selection: $selectedItem, matching: .images) {
                                HStack {
                                    Image(systemName: "photo")
                                        .foregroundStyle(.lilac200)
                                        .font(.title2)
                                        .fontWeight(.regular)
                                    
                                    Text("select")
                                        .foregroundStyle(.lilac100)
                                        .hidden(!attributedText.isEmpty, remove: !attributedText.isEmpty)
                                }
                                .padding(shouldAddPadding: attributedText.isEmpty)
                            }
                            .buttonStyle(CustomButtonStyle())
                            .onChange(of: selectedItem) {
                                Task {
                                    if let data = try? await selectedItem?.loadTransferable(type: Data.self),
                                       let image = UIImage(data: data)?.cgImage {
                                        try setAttributedText(viewModel.recognizeText(of: image))
                                        selectedItem = nil
                                    }
                                }
                            }
                            
                            Spacer()
                                .hidden(attributedText.isEmpty, remove: attributedText.isEmpty)
                            
                            Button {
                                viewModel.play(textToSpeak: attributedText.string)
                                micButtonTapped += 1
                            } label: {
                                SpeakerImage(volumeLevel: viewModel.outputVolume, filled: viewModel.isPlaying)
                                    .foregroundStyle(.lilac200)
                                    .font(.title2)
                                    .fontWeight(.regular)
                                    .contentTransition(.symbolEffect(.replace))
                            }
                            .buttonStyle(CustomButtonStyle())
                            .hidden(attributedText.isEmpty, remove: attributedText.isEmpty)
                            .sensoryFeedback(.impact(flexibility: .rigid, intensity: 1),
                                             trigger: micButtonTapped)
                            
                            Button {
                                setAttributedText("")
                                questionText = ""
                                viewModel.stopPlaying()
                                clearAttributedTextButtonTapped += 1
                            } label: {
                                Image(systemName: "xmark")
                                    .foregroundStyle(.lilac200)
                                    .font(.title2)
                                    .fontWeight(.regular)
                            }
                            .buttonStyle(CustomButtonStyle())
                            .hidden(attributedText.isEmpty, remove: attributedText.isEmpty)
                            .sensoryFeedback(.impact(flexibility: .rigid, intensity: 1),
                                             trigger: clearAttributedTextButtonTapped)
                        }
                    }
                    .padding(.vertical, 32)
                    .padding(.horizontal, 18)
                }
            
            QuestionTextField()
                .padding(.bottom)
                .hidden(attributedText.isEmpty, remove: attributedText.isEmpty)
        }
        .padding(.horizontal)
        .onChange(of: attributedText.string) { _, newValue in
            setUpdatedSessionData(newValue)
        }
        .onAppear {
            let text = viewModel.sessions[viewModel.sessionIndex].text
            onAppearUpdatedAttributedText = text.isEmpty
            setAttributedText(text)
        }
        .sheet(isPresented: $isShowingScannerSheet) { makeScannerView().ignoresSafeArea() }
    }
}

// MARK: - Private Methods

private extension SessionView {
    func setAttributedText(_ text: String) {
        withAnimation(.bouncy(duration: 1)) {
            attributedText = NSMutableAttributedString(string: text,
                                                       attributes: [.foregroundColor: colorScheme == .dark
                                                                    ? UIColor.white : UIColor.black,
                                                                    .font: UIFontMetrics(forTextStyle: .body)
                                                                    .scaledFont(for: .preferredFont(forTextStyle: .body))])
        }
    }
    
    func setUpdatedSessionData(_ text: String) {
        withAnimation(.bouncy(duration: 1)) {
            if onAppearUpdatedAttributedText {
                viewModel.sessions[viewModel.sessionIndex].text = text
                viewModel.sessions[viewModel.sessionIndex].lastChange = Date()
            }
            onAppearUpdatedAttributedText = true
        }
    }
    
    func submitQuestion() {
        if !questionText.isEmpty {
            let result = viewModel.findAnswer(for: questionText,
                                              in: viewModel.sessions[viewModel.sessionIndex].text,
                                              colorScheme: colorScheme)
            
            if let attributedString = result.attributedText {
                attributedText = attributedString
            }
            questionText = result.questionText
        }
    }
}

// MARK: - Session View Content Views

private extension SessionView {
    
    // MARK: - Scanner View
    
    @ViewBuilder
    func makeScannerView() -> ScannerView {
        ScannerView { textPerPage in
            if let text = textPerPage?
                .joined(separator: "\n")
                .trimmingCharacters(in: .whitespacesAndNewlines) {
                setAttributedText(text)
            }
            isShowingScannerSheet = false
        }
    }
    
    // MARK: - Question Text Field
    
    @ViewBuilder
    func QuestionTextField() -> some View {
        HStack {
            TextField("question text field", text: $questionText.animation(.bouncy(duration: 1)))
                .tint(.lilac400)
                .submitLabel(.search)
                .onSubmit {
                    submitQuestion()
                }
            
            Button {
                questionText = ""
                clearQuestionButtonTapped += 1
            } label: {
                Image(systemName: "xmark.circle")
                    .foregroundStyle(.darkBlue500, .lilac400)
                    .font(.largeTitle)
            }
            .hidden(questionText.isEmpty)
            .sensoryFeedback(.impact(flexibility: .rigid, intensity: 1),
                             trigger: clearQuestionButtonTapped)
            Button {
                submitQuestion()
                submitQuestionButtonTapped += 1
            } label: {
                Image(systemName: "magnifyingglass.circle")
                    .foregroundStyle(.darkBlue500, .lilac400)
                    .font(.largeTitle)
            }
            .hidden(questionText.isEmpty)
            .sensoryFeedback(.impact(flexibility: .rigid, intensity: 1),
                             trigger: submitQuestionButtonTapped)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .overlay(
            Capsule()
                .stroke(LinearGradient(colors: [.darkBlue300, .lilac200],
                                       startPoint: .topLeading,
                                       endPoint: .topTrailing),
                        lineWidth: 2)
        )
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
