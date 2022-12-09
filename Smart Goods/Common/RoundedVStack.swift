//
//  RoundedVStack.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 04.12.22.
//

import SwiftUI

struct RoundedVStack<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        VStack {
            content
        }
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.gray.opacity(0.3))
        )
    }
}
