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
        Text("Add New Secure Session")
            .foregroundStyle(.darkBlue600)
    }

    var message: Text? {
        Text("By creating New Sessions you can scan articles and ask them questions!")
            .foregroundStyle(.darkBlue600)
    }

    var image: Image? {
        Image(systemName: "doc.questionmark.rtl")
    }
}
