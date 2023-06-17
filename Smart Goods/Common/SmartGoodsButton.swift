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
            if isLoading {
                ProgressView()
                    .tint(.white)
                    .progressViewStyle(.circular)
                    .frame(maxWidth: .infinity)
                    .padding()
            } else {
                Text(text)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .bold()
            }
        }
        .background(AppColor.primary.color.opacity(0.9))
        .cornerRadius(8)
        .padding()
        .onTapGesture {
            action()
        }
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
