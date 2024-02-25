//
//  Extention.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 2/25/24.
//

import SwiftData

extension ModelContext: Hashable {
    @MainActor public func hash(into hasher: inout Hasher) {
        hasher.combine(container.mainContext)
    }
}
