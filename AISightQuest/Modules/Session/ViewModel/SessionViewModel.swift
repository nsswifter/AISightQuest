//
//  SessionViewModel.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 2/25/24.
//

import SwiftUI
import SwiftData
import Vision
import AVFoundation

extension SessionView {
    
    // MARK: - Session View Model
    
    @Observable
    class ViewModel {
        private var modelContext: ModelContext
        private let speechManager = SpeechManager()

        let sessionIndex: Int
        var sessions: [Session] = []
        
        init(modelContext: ModelContext, sessionIndex: Int) {
            self.modelContext = modelContext
            self.sessionIndex = sessionIndex
            fetchData()
        }
        
        func fetchData() {
            do {
                let descriptor = FetchDescriptor<Session>(sortBy: [SortDescriptor(\.lastChange, order: .reverse)])
                sessions = try modelContext.fetch(descriptor)
            } catch {
                print("Fetch failed")
            }
        }
        
        // MARK: - Speech Manager
        
        var isPlaying: Bool { speechManager.isPlaying }
        
        var playingProgress: Double { speechManager.playingProgress }

        func stopPlaying() { speechManager.stop() }

        func play(textToSpeak: String) {
            if speechManager.isPlaying {
                speechManager.stop()
            } else {
                speechManager.speak(text: textToSpeak)
            }
        }
        
        // MARK: - BERT Core ML Model

        func findAnswer(for question: String,
                        in context: String,
                        colorScheme: ColorScheme) -> (attributedText: NSAttributedString?, questionText: String){
            // Use the BERT model to search for the answer.
            let answer = BERT().findAnswer(for: question, in: context)
            
            // Highlight the answer substring in the original text.
            var attributedText: NSAttributedString?
            if answer.base == context {
                let bodyFont = UIFont.preferredFont(forTextStyle: .body)
                let boldFont = UIFont.systemFont(ofSize: bodyFont.pointSize, weight: .bold)
                
                let bodyScaledFont = UIFontMetrics(forTextStyle: .body).scaledFont(for: bodyFont)
                let boldScaledFont = UIFontMetrics(forTextStyle: .body).scaledFont(for: boldFont)

                let mutableAttributedText = NSMutableAttributedString(string: context,
                                                                       attributes: [.foregroundColor: colorScheme == .dark ? UIColor.white : UIColor.black,
                                                                                    .font: bodyScaledFont])

                let location = answer.startIndex.utf16Offset(in: context)
                let length = answer.endIndex.utf16Offset(in: context) - location
                let answerRange = NSRange(location: location, length: length)

                mutableAttributedText.addAttributes([.foregroundColor: UIColor.darkBlue500,
                                                     .font: boldScaledFont],
                                                    range: answerRange)
                attributedText = mutableAttributedText
            }
            return (attributedText, String(answer))
        }
        
        // MARK: - Vision Recognize Text

        func recognizeText(of image: CGImage) throws -> String {
            let request = VNRecognizeTextRequest()
            request.recognitionLevel = .accurate
            try VNImageRequestHandler(cgImage: image, options: [:]).perform([request])
                        
            return request.results?
                .compactMap { $0.topCandidates(1).first?.string }
                .joined(separator: "\n") ?? ""
        }
        
        // MARK: - AVFoundation Related Methods
        
        var outputVolume: Float {
            AVAudioSession.sharedInstance().outputVolume
        }
    }
}
