//
//  LoginView.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 16.06.23.
//

import SwiftUI
import ComposableArchitecture

struct LoginView: View {

    let store: StoreOf<LoginCore>

    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                Image("icon")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(8)

                Spacer()

                SmartGoodsTextField(
                    imageName: "person.fill",
                    placeholderText: "username",
                    text: viewStore.binding(\.$login.username),
                    isSecure: false
                )

                SmartGoodsTextField(
                    imageName: "lock.fill",
                    placeholderText: "password",
                    text: viewStore.binding(\.$login.password),
                    isSecure: true
                )

                Text("Don't have an account? Sign up now.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(AppColor.info.color)
                    .font(.subheadline)
                    .onTapGesture {
                        viewStore.send(.showRegister)
                    }
                    .padding(.bottom, 20)

                if case .error = viewStore.account {
                    Text("Username or password are incorrect.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(AppColor.error.color)
                        .font(.subheadline)
                }

                Spacer()

                SmartGoodsButton(
                    text: "LOGIN",
                    isLoading: viewStore.account.isLoading,
                    action: {
                        viewStore.send(.login)
                    }
                )
            }
            .padding()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(
            store: Store(
                initialState: LoginCore.State(),
                reducer: LoginCore()
            )
        )
    }
}
