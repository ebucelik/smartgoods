//
//  LoadingView.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 04.12.22.
//

import SwiftUI

struct LoadingView: View {
    let tint: Color
    let fullScreen: Bool

    init(tint: Color = AppColor.background.color, fullScreen: Bool = false) {
        self.tint = tint
        self.fullScreen = fullScreen
    }

    var body: some View {
        if fullScreen {
            VStack {
                Spacer()

                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(tint)

                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(AppColor.background.color)
        } else {
            ProgressView()
                .progressViewStyle(.circular)
                .tint(tint)
        }
    }
}
