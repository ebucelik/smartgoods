//
//  RegisterView.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 17.06.23.
//

import SwiftUI
import ComposableArchitecture

struct RegisterView: View {
    let store: StoreOf<RegisterCore>

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
                    placeholderText: "firstname",
                    text: viewStore.binding(\.$register.firstName),
                    isSecure: false
                )

                SmartGoodsTextField(
                    imageName: "person.fill",
                    placeholderText: "lastname",
                    text: viewStore.binding(\.$register.lastName),
                    isSecure: false
                )

                SmartGoodsTextField(
                    imageName: "person.fill",
                    placeholderText: "username",
                    text: viewStore.binding(\.$register.username),
                    isSecure: false
                )

                SmartGoodsTextField(
                    imageName: "lock.fill",
                    placeholderText: "password",
                    text: viewStore.binding(\.$register.password),
                    isSecure: true
                )

                Text("Already have an account? Sign in now.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(AppColor.info.color)
                    .font(.subheadline)
                    .onTapGesture {
                        viewStore.send(.showLogin)
                    }

                Spacer()

                SmartGoodsButton(
                    text: "REGISTER",
                    isLoading: viewStore.account.isLoading,
                    action: {
                        viewStore.send(.register)
                    }
                )
            }
            .padding()
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(
            store: Store(
                initialState: RegisterCore.State(),
                reducer: RegisterCore()
            )
        )
    }
}
