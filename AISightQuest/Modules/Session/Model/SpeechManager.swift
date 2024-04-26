//
//  SpeechManager.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 4/12/24.
//

import SwiftUI
import Speech

@Observable
class SpeechManager: NSObject, AVSpeechSynthesizerDelegate {
    private let synthesizer = AVSpeechSynthesizer()
    var isPlaying: Bool = false
    var playingProgress: Double = 0.0
    
    override init() {
        super.init()
        synthesizer.delegate = self
    }

    func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = 0.45
        utterance.pitchMultiplier = 0.85
        utterance.postUtteranceDelay = 0.45
        utterance.voice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.siri_male_en-US_compact")
        synthesizer.speak(utterance)
    }

    func stop() {
        synthesizer.stopSpeaking(at: .word)
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        // Reset progress when speech starts
        Task { @MainActor in
            isPlaying = true
            playingProgress = 0
        }
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        // Calculate progress based on the range of spoken characters
        Task { @MainActor in
            let totalCharacters = utterance.speechString.count
            let spokenCharacters = characterRange.location + characterRange.length
            withAnimation(.easeInOut) {
                playingProgress = Double(spokenCharacters) / Double(totalCharacters)
            }
        }
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        // Reset progress when speech finishes
        Task { @MainActor in
            isPlaying = false
            playingProgress = 0
        }
    }
}
