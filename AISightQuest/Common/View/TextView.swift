//
//  TextView.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 3/3/24.
//

import SwiftUI

// MARK: - Text View

struct TextView: UIViewRepresentable {
    @Binding var attributedText: NSAttributedString
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.autocapitalizationType = .sentences
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.backgroundColor = .clear
        textView.showsHorizontalScrollIndicator = false
        textView.showsVerticalScrollIndicator = false
        textView.tintColor = .darkBlue500
        textView.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: .preferredFont(forTextStyle: .body))
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.attributedText = attributedText
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(innerAttributedText: $attributedText)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        @Binding var innerAttributedText: NSAttributedString
        private var textViewDidChangeSelectionTask: Task<Void, Error>?

        init(innerAttributedText: Binding<NSAttributedString>) {
            self._innerAttributedText = innerAttributedText
        }
        
        func textViewDidChangeSelection(_ textView: UITextView) {
            textViewDidChangeSelectionTask?.cancel()
            textViewDidChangeSelectionTask = Task {
                withAnimation(.bouncy(duration: 1)) {
                    innerAttributedText = textView.attributedText
                }
            }
        }
    }
}

// MARK: - Text View Preview

#if DEBUG
#Preview {
    TextView(attributedText: .constant(NSAttributedString(string: "Hello World")))
}
#endif
