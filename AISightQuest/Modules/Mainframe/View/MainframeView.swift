//
//  MainframeView.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 2/22/24.
//

import SwiftUI
import SwiftData

// MARK: - Mainframe View

struct MainframeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var sessions: [Session]

    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(sessions) { session in
                    NavigationLink {
                        // TODO: Route to Session View
                        Text(session.text)
                    } label: {
                        Text(session.name)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Session(name: "hi")
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(sessions[index])
            }
        }
    }
}

// MARK: - Mainframe View Preview

#if DEBUG
#Preview {
    MainframeView()
        .modelContainer(for: Session.self, inMemory: true)
}
#endif
