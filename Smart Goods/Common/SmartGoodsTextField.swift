//
//  SmartGoodsTextField.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 16.06.23.
//

import SwiftUI

struct SmartGoodsTextField: View {
    let imageName: String
    let placeholderText: String
    @Binding var text: String
    let isSecure: Bool

    var body: some View {
        HStack {
            Image(systemName: imageName)
                .foregroundColor(AppColor.primary.color)

            if isSecure {
                SecureField(
                    placeholderText,
                    text: $text
                )
                .textInputAutocapitalization(.never)
            } else {
                TextField(
                    placeholderText,
                    text: $text
                )
                .textInputAutocapitalization(.never)
            }
        }
        .padding()
        .background(AppColor.primary.color.opacity(0.2))
        .cornerRadius(8)
    }
}

struct SmartGoodsTextField_Previews: PreviewProvider {
    static var previews: some View {
        SmartGoodsTextField(
            imageName: "person.fill",
            placeholderText: "username",
            text: .constant("nothing"),
            isSecure: true
        )
    }
}
