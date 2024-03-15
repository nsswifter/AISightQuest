//
//  MainframeBackgroundView.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 3/14/24.
//

import SwiftUI

// MARK: - Mainframe Background View

struct MainframeBackgroundView: View {
    @State private var start = UnitPoint(x: -0.5, y: -2)
    @State private var end = UnitPoint(x: 4, y: 0)
    private let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [
            .white, .darkBlue500, .lilac400, .white,
            .darkBlue500, .white, .lilac300, .white,
            .white, .darkBlue300, .lilac200, .white
        ]), startPoint: start, endPoint: end)
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

// MARK: - Mainframe Background Preview

#if DEBUG
#Preview {
    MainframeBackgroundView()
}
#endif
