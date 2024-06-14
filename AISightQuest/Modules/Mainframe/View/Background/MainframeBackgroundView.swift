//
//  MainframeBackgroundView.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 3/14/24.
//

import SwiftUI

// MARK: - Mainframe Background View

struct MainframeBackgroundView: View {
    var body: some View {
        if #available(iOS 18, *) {
            MeshGradientBackgroundView()
        } else {
            LinearGradientBackgroundView()
        }
    }
}

// MARK: - Mainframe Background Preview

#if DEBUG
#Preview {
    MainframeBackgroundView()
}
#endif
