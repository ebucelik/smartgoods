//
//  SmartGoodsButton.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 16.06.23.
//

import SwiftUI

struct SmartGoodsButton: View {
    let text: String
    let isLoading: Bool
    let action: () -> Void

    var body: some View {
        HStack {
            Text(text)
                .frame(maxWidth: .infinity)
                .padding()
        }
        .background(AppColor.primary.color.opacity(0.9))
        .cornerRadius(8)
        .padding()
    }
}

struct SmartGoodsButton_Previews: PreviewProvider {
    static var previews: some View {
        SmartGoodsButton(
            text: "Login",
            isLoading: false,
            action: {}
        )
    }
}
