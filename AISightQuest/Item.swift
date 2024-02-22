//
//  Item.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 2/22/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
