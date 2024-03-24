//
//  ScanDocumentTip.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 3/24/24.
//

import SwiftUI
import TipKit

struct ScanDocumentTip: Tip {
    var title: Text {
        Text("Scan and Capture")
            .foregroundStyle(.darkBlue600)
    }

    var message: Text? {
        Text("By scanning documents, you can obtain their content as plain text.")
            .foregroundStyle(.darkBlue600)
    }

    var image: Image? {
        Image(systemName: "doc.viewfinder.fill")
    }
}
