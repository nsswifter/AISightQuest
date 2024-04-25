//
//  View.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 2/25/24.
//

import SwiftUI

// MARK: - Hide Keyboard

extension View {
    /// Hide or show the view based on a boolean value.
    ///
    /// Example for visibility:
    ///
    ///     Text("Label")
    ///         .hidden(true)
    ///
    /// Example for complete removal:
    ///
    ///     Text("Label")
    ///         .hidden(true, remove: true)
    ///
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
    @ViewBuilder func hidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
    
    /// A convenience method for hiding the keyboard when editing ends on a view that is currently the first responder.
    func hideKeyboard() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.filter { $0.isKeyWindow }.first?.endEditing(true)
        }
    }
    
    /// A modifier to detect when the keyboard is closed and perform an action.
    func onKeyboardHide(perform action: @escaping () -> Void) -> some View {
        modifier(KeyboardHidingModifier(action: action))
    }
    
    /// Adds padding to the view conditionally based on the `shouldAddPadding` parameter.
    ///
    /// - Parameters:
    ///   - shouldAddPadding: A Boolean value indicating whether padding should be added to the view.
    ///   - edges: The set of edges along which to add padding.
    ///   - length: The amount of padding to apply to the specified edges.
    /// - Returns: A view modified with padding if `shouldAddPadding` is `true`, otherwise returns the original view.
    @ViewBuilder func padding(shouldAddPadding addPadding: Bool, _ edges: Edge.Set = .all, _ length: CGFloat? = nil) -> some View {
        if addPadding {
            self.padding(edges, length)
        } else {
            self
        }
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
