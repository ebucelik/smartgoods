//
//  ErrorView.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 28.12.22.
//

import SwiftUI

struct ErrorView: View {
    public var error: String

    init(error: String = "Something bad happened :(") {
        self.error = error
    }

    var body: some View {
        Text(error)
            .font(.title2)
    }
}
