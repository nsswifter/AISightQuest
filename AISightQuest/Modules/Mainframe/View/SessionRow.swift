//
//  SessionRow.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 2/23/24.
//

import SwiftUI

struct SessionRow: View {
    @Binding var session: Session
    
    @FocusState private var isTextFieldFocused
    @State private var shouldRename = false

    var body: some View {
        HStack {
            Image(systemName: shouldRename ? "pencil" : "swift")
                .foregroundStyle(.lilac500)
                .font(.title3)

            if shouldRename {
                TextField("New Session", text: $session.name)
                    .focused($isTextFieldFocused)
                    .onSubmit() {
                        shouldRename = false
                    }
            } else {
                Text(session.name)
                    .contextMenu {
                        Button("Rename") {
                            shouldRename = true
                            isTextFieldFocused = true
                        }
                    }
            }
        }
    }
}

#Preview {
    SessionRow(session: .constant(Session(name: "New Session", lastChange: Date())))
}
