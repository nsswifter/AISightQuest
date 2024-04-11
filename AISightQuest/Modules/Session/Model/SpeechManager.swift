//
//  SpeechManager.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 4/12/24.
//

import Speech

@Observable
class SpeechManager: NSObject, AVSpeechSynthesizerDelegate {
    private let synthesizer = AVSpeechSynthesizer()
    var isPlaying: Bool = false

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
        isPlaying = true
    }

    func stop() {
        synthesizer.stopSpeaking(at: .word)
        isPlaying = false
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        Task { @MainActor in
            isPlaying = false
        }
    }
}
