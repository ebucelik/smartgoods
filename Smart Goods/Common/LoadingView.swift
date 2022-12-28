//
//  LoadingView.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 04.12.22.
//

import SwiftUI

struct LoadingView: View {
    let tint: Color

    init(tint: Color = .white) {
        self.tint = tint
    }

    var body: some View {
        ProgressView()
            .progressViewStyle(.circular)
            .tint(tint)
    }
}
