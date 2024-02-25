//
//  MainframeFactory.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 2/25/24.
//

import SwiftData

typealias MainframeFactory = MainframeViewFactory

protocol MainframeViewFactory {
    func makeMainframeView(modelContainer: ModelContainer) -> MainframeView
}
