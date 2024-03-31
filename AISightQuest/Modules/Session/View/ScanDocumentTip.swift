//
//  ScanDocumentTip.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 3/24/24.
//

import SwiftUI
import TipKit

// MARK: - Scan Document Tip

struct ScanDocumentTip: Tip {
    var title: Text {
        Text("scan document tip title")
            .foregroundStyle(.darkBlue600)
    }

    var message: Text? {
        Text("scan document tip message")
            .foregroundStyle(.darkBlue600)
    }

    var image: Image? {
        Image(systemName: "doc.viewfinder.fill")
    }
}
