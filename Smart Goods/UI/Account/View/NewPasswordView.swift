//
//  NewPasswordView.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 18.06.23.
//

import SwiftUI
import ComposableArchitecture

struct NewPasswordView: View {
    let store: StoreOf<NewPasswordCore>

    var body: some View {
        WithViewStore(store) { viewStore in
            VStack(spacing: 15) {
                SmartGoodsTextField(
                    imageName: "lock.fill",
                    placeholderText: "New password",
                    text: viewStore.binding(\.$newPassword.controlNewPassword),
                    isSecure: true
                )

                SmartGoodsTextField(
                    imageName: "lock.fill",
                    placeholderText: "Repeat new password",
                    text: viewStore.binding(\.$newPassword.newPassword),
                    isSecure: true
                )

                SmartGoodsTextField(
                    imageName: "lock.fill",
                    placeholderText: "Old password",
                    text: viewStore.binding(\.$newPassword.oldPassword),
                    isSecure: true
                )

                Spacer()

                SmartGoodsButton(
                    text: "Change password",
                    isLoading: viewStore.info.isLoading
                ) {
                    viewStore.send(.changePassword)
                }
            }
            .padding()
        }
    }
}

struct NewPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        NewPasswordView(
            store: Store(
                initialState: NewPasswordCore.State(account: .mock),
                reducer: NewPasswordCore()
            )
        )
    }
}
