//
//  Session.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 2/22/24.
//

import Foundation
import SwiftData

@Model
final class Session {
    var name: String
    var text: String = ""
    var lastChange: Date
    
    init(name: String, lastChange: Date) {
        self.name = name
        self.lastChange = lastChange
    }
}
