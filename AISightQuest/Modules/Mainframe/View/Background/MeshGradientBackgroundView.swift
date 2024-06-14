//
//  MeshGradientBackgroundView.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 6/14/24.
//

import SwiftUI

// MARK: - Mesh Gradient Background View

@available(iOS 18, *)
struct MeshGradientBackgroundView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var time: Float = 0.0
    @State private var animationTimer: Timer?
    
    private var lightModeColors: [Color] = [
        .white,     .lilac300,      .white,
        .lilac200,  .darkBlue300,   .white,
        .white,     .white,         .white
    ]
    private var darkModeColors: [Color] = [
        .black,     .lilac300,      .black,
        .lilac200,  .darkBlue300,   .black,
        .black,     .black,         .black
    ]
    
    var body: some View {
        MeshGradient(width: 3, height: 3, points: [
            .init(0, 0), .init(0.5, 0), .init(1, 0),
            [calculateSinusoidalValue(in: -0.8...(-0.2), offset: 0.439, timeScale: 0.342, time: time),
             calculateSinusoidalValue(in: 0.3...0.7, offset: 3.42, timeScale: 0.984, time: time)],
            [calculateSinusoidalValue(in: 0.1...0.8, offset: 0.239, timeScale: 0.084, time: time),
             calculateSinusoidalValue(in: 0.2...0.8, offset: 5.21, timeScale: 0.242, time: time)],
            [calculateSinusoidalValue(in: 1.0...1.5, offset: 0.939, timeScale: 0.084, time: time),
             calculateSinusoidalValue(in: 0.4...0.8, offset: 0.25, timeScale: 0.642, time: time)],
            [calculateSinusoidalValue(in: -0.8...0.0, offset: 1.439, timeScale: 0.442, time: time),
             calculateSinusoidalValue(in: 1.4...1.9, offset: 3.42, timeScale: 0.984, time: time)],
            [calculateSinusoidalValue(in: 0.3...0.6, offset: 0.339, timeScale: 0.784, time: time),
             calculateSinusoidalValue(in: 1.0...1.2, offset: 1.22, timeScale: 0.772, time: time)],
            [calculateSinusoidalValue(in: 1.0...1.5, offset: 0.939, timeScale: 0.056, time: time),
             calculateSinusoidalValue(in: 1.3...1.7, offset: 0.47, timeScale: 0.342, time: time)]
        ], colors: colorScheme == .dark ? darkModeColors : lightModeColors)
        .onAppear {
            animationTimer = Timer.scheduledTimer(withTimeInterval: 0.009, repeats: true) { _ in
                time += 0.02
            }
        }
        .ignoresSafeArea()
    }
    
}

// MARK: - Private Methods

@available(iOS 18, *)
private extension MeshGradientBackgroundView {
    /// Calculates the value of a sinusoidal function at a given time.
    ///
    /// - Parameters:
    ///   - range: The range within which the sinusoidal function value should be calculated.
    ///   - offset: The offset of the sinusoidal function.
    ///   - timeScale: The time scale of the sinusoidal function.
    ///   - time: The time at which the sinusoidal function value should be calculated.
    ///
    /// - Returns: The value of the sinusoidal function at the given time.
    func calculateSinusoidalValue(in range: ClosedRange<Float>,
                                  offset: Float,
                                  timeScale: Float,
                                  time: Float) -> Float {
        let amplitude = (range.upperBound - range.lowerBound) / 2
        let midPoint = (range.upperBound + range.lowerBound) / 2
        return midPoint + amplitude * sin(timeScale * time + offset)
    }
}

// MARK: - Mesh Gradient Background Preview

#if DEBUG
@available(iOS 18, *)
#Preview {
    MainframeBackgroundView()
}
#endif
