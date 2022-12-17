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
                VStack(spacing: 24) {
                    switch viewStore.state.uuid {
                    case .loading:
                        ProgressView()
                            .progressViewStyle(.circular)
                    case let .loaded(uuid):
                        loggedInBody(uuid)

                    default:
                        loggedOutBody()
                    }
                }
                .padding(.horizontal, 16)
                .navigationTitle("Account")
                .onAppear {
                    if case .none = viewStore.uuid {
                        viewStore.send(.checkIfUuidAvailable("uuid"))
                    }
                }
            }
        }
    }

    @ViewBuilder
    private func loggedInBody(_ uuid: String) -> some View {
        Image(systemName: "person.crop.circle").renderingMode(.template)
            .resizable()
            .frame(maxWidth: 100, maxHeight: 100)
            .foregroundColor(AppColor.quinary.color)
            .padding(.top, 24)

        Text("Your UUID is \(uuid)")
            .padding()

        Spacer()
    }

    @ViewBuilder func loggedOutBody() -> some View {
        Image(systemName: "info.circle").renderingMode(.template)
            .resizable()
            .frame(maxWidth: 100, maxHeight: 100)
            .foregroundColor(AppColor.quinary.color)

        Text("Uups, you are not logged in.")
            .padding()
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(
            store: Store(
                initialState: AccountCore.State(),
                reducer: AccountCore()
            )
        )
    }
}
