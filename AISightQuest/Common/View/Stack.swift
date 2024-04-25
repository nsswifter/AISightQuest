//
//  Stack.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 4/26/24.
//

import SwiftUI

/// A custom stack view that arranges its child views horizontally or vertically based on the specified orientation.
///
/// Use the `Stack` view to dynamically stack views either horizontally or vertically.
///
/// Example:
/// ```swift
/// Stack(orientation: .horizontal) {
///     Text("Hello")
///     Text("World")
/// }
/// ```
///
/// - Note: This view behaves similarly to `HStack` and `VStack` but allows dynamic orientation selection.
///
/// - Parameters:
///   - orientation: The orientation in which to stack the views.
///   - content: A closure containing the views to stack.
///
/// - Returns: A stack view with the specified orientation.
struct Stack<T: View>: View {
    /// The orientation of the stack view.
    let orientation: Orientation
    
    /// The closure containing the views to stack.
    let content: () -> T
    
    /// Initializes a stack view with the specified orientation and content.
    ///
    /// - Parameters:
    ///   - orientation: The orientation in which to stack the views.
    ///   - content: A closure containing the views to stack.
    ///
    /// - Returns: A stack view with the specified orientation and content.
    init(orientation: Orientation, @ViewBuilder content: @escaping () -> T) {
        self.orientation = orientation
        self.content = content
    }
    
    var body: some View {
        switch orientation {
        case .horizontal:
            HStack {
                content()
            }
            
        case .vertical:
            VStack {
                content()
            }
        }
    }
}

// MARK: - Orientation of Stack View

/// An enumeration representing the orientation options for a stack view.
///
/// Use the `Orientation` enumeration to specify whether views in a `Stack` should be arranged horizontally or vertically.
///
/// - horizontal: Views are arranged side by side.
/// - vertical: Views are arranged vertically, one below the other.
extension Stack {
    /// An enumeration representing the orientation options for a stack view.
    enum Orientation {
        /// Views are arranged side by side.
        case horizontal
        
        /// Views are arranged vertically, one below the other.
        case vertical
    }
}

// MARK: - Stack View Preview

#Preview {
    Stack(orientation: .vertical) {
        Image(systemName: "camera")
        Image(systemName: "doc")
        Image(systemName: "photo")
    }
}
