//
//  SessionRow.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 2/23/24.
//

import SwiftUI

// MARK: - Session Row View

struct SessionRow: View {
    @Binding var session: Session
    
    @FocusState private var isTextFieldFocused
    @State private var shouldRename = false

    var body: some View {
        HStack {
            Image(systemName: shouldRename ? "pencil" : "doc.text.image")
                .contentTransition(.symbolEffect(.replace))
                .foregroundStyle(.lilac400)
                .font(.title3)
            
            Group {
                if shouldRename {
                    TextField("new session", text: $session.name)
                        .tint(.lilac400)
                        .focused($isTextFieldFocused)
                        .submitLabel(.done)
                        .onSubmit() {
                            shouldRename = false
                        }
                } else {
                    Text(session.name)
                        .contextMenu {
                            Button("rename") {
                                shouldRename = true
                                isTextFieldFocused = true
                            }
                        }
                }
            }
            .foregroundStyle(.lilac100)
            .onChange(of: isTextFieldFocused) {
                if $1 {
                    UIApplication.shared.sendAction(#selector(UIResponder.selectAll(_:)), to: nil, from: nil, for: nil)
                }
            }
            
            Spacer()
            
            Text(session.lastChange.formatted(date: .abbreviated, time: .shortened))
                .font(.caption2)
                .foregroundStyle(.lilac100.opacity(0.8))
        }
        .onKeyboardHide {
            shouldRename = false
        }
    }
}

// MARK: - Session Row Preview

#if DEBUG
#Preview {
    SessionRow(session: .constant(Session(name: "New Session", lastChange: Date())))
}
#endif
