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
        var title: String
        var text: String
    }
    
    struct Data {
        static var intros: [IntroItem] = [
            IntroItem(imageName: "Education-Lottie", title: "Sample", text: "Sample"),
            IntroItem(imageName: "AI-Robot-Lottie", title: "Sample", text: "Sample")
        ]
        
        static var firstIntro = IntroItem(imageName: "AI-Sight-Quest-Lottie", title: "Sample", text: "Sample")
        static var lastIntro = IntroItem(imageName: "Privacy-Lottie", title: "Sample", text: "Sample")
    }
}
