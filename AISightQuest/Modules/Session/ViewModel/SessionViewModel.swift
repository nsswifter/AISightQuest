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
        
        func findAnswer(for question: String, in context: String) -> (attributedText: NSAttributedString?, questionText: String){
            // Use the BERT model to search for the answer.
            let answer = BERT().findAnswer(for: question, in: context)
            
            // Highlight the answer substring in the original text.
            var attributedText: NSAttributedString?
            if answer.base == context {
                let mutableAttributedText = NSMutableAttributedString(string: context,
                                                                      attributes: [.foregroundColor: UIColor.black,
                                                                                   .font: UIFontMetrics(forTextStyle: .body)
                                                                                   .scaledFont(for: UIFont.systemFont(ofSize: 17))])
                
                let location = answer.startIndex.utf16Offset(in: context)
                let length = answer.endIndex.utf16Offset(in: context) - location
                let answerRange = NSRange(location: location, length: length)
                
                mutableAttributedText.addAttributes([.foregroundColor: UIColor.darkBlue500,
                                                     .font: UIFontMetrics(forTextStyle: .body)
                                                     .scaledFont(for: UIFont(name: "Avenir-HeavyOblique", size: 17) ?? UIFont.boldSystemFont(ofSize: 17))],
                                                    range: answerRange)
                attributedText = mutableAttributedText
            }
            return (attributedText, String(answer))
        }
    }
}
