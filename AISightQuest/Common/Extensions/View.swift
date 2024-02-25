//
//  View.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 2/25/24.
//

import SwiftUI

// MARK: - Hide Keyboard

extension View {
    /// A convenience method for hiding the keyboard when editing ends on a view that is currently the first responder.
    func hideKeyboard() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let window = windowScene.windows.filter { $0.isKeyWindow }.first
            window?.endEditing(true)
        }
    }
    
    /// A modifier to detect when the keyboard is closed and perform an action.
    func onKeyboardHide(perform action: @escaping () -> Void) -> some View {
        return self.modifier(KeyboardHidingModifier(action: action))
    }
}

/// A view modifier that detects when the keyboard is about to be hidden and performs a specified action.
private struct KeyboardHidingModifier: ViewModifier {
    /// The action to perform when the keyboard is about to be hidden.
    let action: () -> Void

    /// Applies the view modifier to the given content, adding an observer to detect keyboard hide events.
    /// - Parameter content: The content to which the modifier is applied.
    /// - Returns: A modified view that triggers the specified action when the keyboard is about to be hidden.
    func body(content: Content) -> some View {
        content
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                action()
            }
    }
}
