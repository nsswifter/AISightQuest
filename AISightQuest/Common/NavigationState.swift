//
//  NavigationState.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 2/25/24.
//

import Foundation

class NavigationState: ObservableObject {
    @Published var routes: [AnyHashable] = []
}
