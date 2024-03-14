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
            IntroItem(imageName: "Education-Lottie", title: "Education View Title", text: "Education View Text"),
            IntroItem(imageName: "AI-Robot-Lottie", title: "AI Robot View Title", text: "AI Robot View Text")
        ]
        
        static var firstIntro = IntroItem(imageName: "AI-Sight-Quest-Lottie", title: "", text: "First View Text")
        static var lastIntro = IntroItem(imageName: "Privacy-Lottie", title: "Privacy View Title", text: "Privacy View Text")
    }
}
