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
            Image(systemName: shouldRename ? "square.and.pencil.circle" : "doc.viewfinder.fill")
                .foregroundStyle(.lilac500)
                .font(.title3)

            if shouldRename {
                TextField("New Session", text: $session.name)
                    .focused($isTextFieldFocused)
                    .submitLabel(.done)
                    .onSubmit() {
                        shouldRename = false
                    }
            } else {
                Text(session.name)
                    .foregroundStyle(.black)
                    .contextMenu {
                        Button("Rename") {
                            shouldRename = true
                            isTextFieldFocused = true
                        }
                    }
            }
        }
        .onKeyboardHide {
            shouldRename = false
        }
    }
}

#Preview {
    SessionRow(session: .constant(Session(name: "New Session", lastChange: Date())))
}
