//
//  CustomProgressView.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 4/26/24.
//

import SwiftUI

// MARK: - Custom Progress View

/// A custom progress view that visually represents progress with a colored bar.
struct CustomProgressView: View {
    // The progress value, ranging from 0.0 to 1.0.
    var progress: Double
    var height: Double = 4
    var progressColor: Color = .accentColor
    var backgroundColor: Color = .gray.opacity(0.3)
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                backgroundColor
                
                progressColor
                    .frame(width: geometry.size.width * progress)
                    .clipShape(RoundedRectangle(cornerRadius: height))
            }
        }
        .frame(height: height)
        .clipShape(RoundedRectangle(cornerRadius: height))
    }
}

// MARK: - Custom Progress View Preview

#if DEBUG
#Preview {
    CustomProgressView(progress: 0.4)
}
#endif
