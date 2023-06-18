//
//  AccountView.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 17.12.22.
//

import ComposableArchitecture
import SwiftUI

struct AccountView: View {
    let store: StoreOf<AccountCore>

    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationStack {
                VStack(spacing: 10) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Firstname")
                            .bold()

                        Text(viewStore.account.firstName)
                            .padding(.leading, 8)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Lastname")
                            .bold()

                        Text(viewStore.account.lastName)
                            .padding(.leading, 8)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Username")
                            .bold()

                        Text(viewStore.account.username)
                            .padding(.leading, 8)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Spacer()
                        .frame(height: 25)

                    Text("Change password")
                        .foregroundColor(AppColor.info.color)
                        .onTapGesture {
                            viewStore.send(.showNewPassword)
                        }

                    Spacer()
                }
                .padding()
                .navigationTitle("Account")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Image(systemName: "rectangle.portrait.and.arrow.forward")
                            .foregroundColor(.white)
                            .onTapGesture {
                                viewStore.send(.logout)
                            }
                    }
                }
                .sheet(
                    store: store.scope(
                        state: \.$newPassword,
                        action: AccountCore.Action.newPassword
                    )
                ) { newPasswordStore in
                    NewPasswordView(store: newPasswordStore)
                }
            }
        }
    }
}

#if DEBUG
struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(
            store: Store(
                initialState: AccountCore.State(account: .mock),
                reducer: AccountCore()
            )
        )
    }
}
#endif
