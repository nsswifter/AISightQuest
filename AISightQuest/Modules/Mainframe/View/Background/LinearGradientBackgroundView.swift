//
//  LinearGradientBackgroundView.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 6/14/24.
//

import SwiftUI

struct LinearGradientBackgroundView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var start = UnitPoint(x: -0.5, y: -2)
    @State private var end = UnitPoint(x: 4, y: 0)
    private let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    private var lightModeColors: [Color] = [
        .white,         .darkBlue500,   .lilac400,      .white,
        .darkBlue500,   .white,         .lilac300,      .white,
        .white,         .darkBlue300,   .lilac200,      .white
    ]
    private var darkModeColors: [Color] = [
        .black,         .darkBlue500,   .lilac400,      .black,
        .darkBlue500,   .black,         .lilac300,      .black,
        .black,         .darkBlue300,   .lilac200,      .black
    ]
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: colorScheme == .dark
                                          ? darkModeColors
                                          : lightModeColors),
                       startPoint: start, endPoint: end)
        .animation(Animation.easeInOut(duration: 30)
            .repeatForever(autoreverses: true)
            .speed(1), value: start)
        .animation(Animation.easeInOut(duration: 30)
            .repeatForever(autoreverses: true)
            .speed(1), value: end)
        .onReceive(timer) { _ in
            self.start = UnitPoint(x: 4, y: 0)
            self.end = UnitPoint(x: 0, y: 2)
            self.start = UnitPoint(x: -4, y: 20)
            self.start = UnitPoint(x: 4, y: 0)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    LinearGradientBackgroundView()
}
