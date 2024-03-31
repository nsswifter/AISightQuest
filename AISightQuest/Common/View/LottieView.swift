//
//  LottieView.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 3/3/24.
//

import SwiftUI
import Lottie

// MARK: - Lottie View

/// A SwiftUI view that displays a Lottie animation using a UIViewRepresentable.
struct LottieView: UIViewRepresentable {
    
    // The name of the Lottie animation to display.
    var name: String
    
    // The loop mode of the Lottie animation.
    var loopMode = LottieLoopMode.playOnce
    
    /// Creates a UIView that displays a Lottie animation with the specified name, content mode, and loop mode.
    ///
    /// - Parameters:
    ///   - context: The context of the UIViewRepresentable that owns this view.
    ///   - name: The name of the Lottie animation to display.
    ///   - loopMode: The loop mode of the Lottie animation.
    /// - Returns: A UIView that displays the Lottie animation.
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        
        // Create a container view for the Lottie animation.
        let view = UIView( frame: .zero)
        
        // Create a Lottie animation view with the specified name, content mode, and loop mode.
        let animationView = LottieAnimationView(name: name)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.play()
        
        // Add the animation view to the container view and set its constraints.
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) { }
}

// MARK: - Lottie View Preview

#if DEBUG
#Preview {
    LottieView(name: "AI-Sight-Quest-Lottie")
}
#endif
