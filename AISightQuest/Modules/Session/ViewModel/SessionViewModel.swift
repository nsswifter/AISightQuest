//
//  SessionViewModel.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 2/25/24.
//

import SwiftUI
import SwiftData

extension SessionView {
    
    // MARK: - Session View Model
    
    @Observable
    class ViewModel {
        var modelContext: ModelContext
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
    }
}
