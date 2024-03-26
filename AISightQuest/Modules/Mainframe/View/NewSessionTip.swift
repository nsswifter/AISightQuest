//
//  NewSessionTip.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 3/16/24.
//

import SwiftUI
import TipKit

struct NewSessionTip: Tip {
    var title: Text {
        Text("new session tip title")
            .foregroundStyle(.darkBlue600)
    }

    var message: Text? {
        Text("new session tip message")
            .foregroundStyle(.darkBlue600)
    }

    var image: Image? {
        Image(systemName: "doc.questionmark.rtl")
    }
}
