//
//  SessionFactory.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 2/25/24.
//

import SwiftData

typealias SessionFactory = SessionViewFactory

protocol SessionViewFactory {
    func makeSessionView(modelContext: ModelContext, sessionIndex: Int) -> SessionView
}
