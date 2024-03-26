//
//  Intro.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 3/3/24.
//

import SwiftUI

struct Intro {
    struct IntroItem: Identifiable {
        var id: String = UUID().uuidString
        var imageName: String
        var title: LocalizedStringKey
        var text: LocalizedStringKey
    }
    
    struct Data {
        static var intros: [IntroItem] = [
            IntroItem(imageName: "Education-Lottie", title: "education view title", text: "education view text"),
            IntroItem(imageName: "AI-Robot-Lottie", title: "ai robot view title", text: "ai robot view text")
        ]
        
        static var firstIntro = IntroItem(imageName: "AI-Sight-Quest-Lottie", title: "first view title", text: "first view text")
        static var lastIntro = IntroItem(imageName: "Privacy-Lottie", title: "privacy view title", text: "privacy view text")
    }
}
