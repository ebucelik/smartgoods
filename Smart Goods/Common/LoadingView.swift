//
//  LoadingView.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 04.12.22.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(.circular)
            .tint(.white)
    }
}
