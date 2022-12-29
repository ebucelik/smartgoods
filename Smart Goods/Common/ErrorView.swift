//
//  ErrorView.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 28.12.22.
//

import SwiftUI

struct ErrorView: View {
    public let error: String
    public let action: (() -> Void)?

    init(error: String = "Oups, something bad happened :(", action: (() -> Void)? = nil) {
        self.error = error
        self.action = action
    }

    var body: some View {
        VStack(spacing: 32) {
            Text(error)
                .font(.body.monospaced())

            if let action = action {
                RoundedVStack {
                    Button(action: action) {
                        Text("RETRY")
                            .font(.body.monospaced().bold())
                            .tint(AppColor.secondary.color)
                    }
                    .padding()
                    .background(AppColor.primary.color)
                }
            }
        }
        .padding()
    }
}

struct ErrorView_Previews:PreviewProvider {
    static var previews: some View {
        ErrorView(error: "Error", action: { print("retry") })
    }
}
