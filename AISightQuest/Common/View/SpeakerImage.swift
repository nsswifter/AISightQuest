//
//  SpeakerImage.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 4/26/24.
//

import SwiftUI

// MARK: - Speaker Image View

struct SpeakerImage: View {
    let volumeLevel: Double
    let filled: Bool
    
    var body: some View {
        Image(systemName: speakerIcon)
    }
    
    private var speakerIcon: String {
        switch volumeLevel {
        case 0.66...:
            if filled { "speaker.wave.3.fill" } else { "speaker.wave.3" }
        case 0.33..<0.66:
            if filled { "speaker.wave.2.fill" } else { "speaker.wave.2" }
        case 0.01..<0.33:
            if filled { "speaker.wave.1.fill" } else { "speaker.wave.1" }
        default:
            if filled { "speaker.wave.3.fill" } else { "speaker.wave.3" }
        }
    }
}

// MARK: - Speaker Image View Preview

#if DEBUG
#Preview {
    SpeakerImage(volumeLevel: 0.1, filled: false)
}
#endif
