//
//  CustomButtonStyle.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 3/29/24.
//

import SwiftUI

// MARK: - Custom Button Style

/// A custom button style that applies a bold font, sets a fixed height, and adds a capsule-shaped background with gradient colors.
struct CustomButtonStyle: ButtonStyle {
    /// Constructs the visual appearance and interaction behavior of the button.
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .bold()
            .frame(height: 40)
            .frame(minWidth: 40)
            .background {
                Capsule()
                    .fill(LinearGradient(colors: configuration.isPressed ? [Color.lilac500]
                                         : [Color.darkBlue500, .darkBlue900],
                                         startPoint: .top,
                                         endPoint: .bottom))
            }
    }
}

// MARK: - Custom Button Style Preview

#if DEBUG
#Preview {
    Button { 
        print("Pressed")
    } label: {
        HStack {
            Image(systemName: "plus")
                .foregroundStyle(.lilac200)
            Text("session")
                .foregroundStyle(.lilac100)
        }
    }
    .buttonStyle(CustomButtonStyle())
}
#endif
