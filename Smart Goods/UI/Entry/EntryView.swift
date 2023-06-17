//
//  EntryView.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 17.06.23.
//

import SwiftUI
import ComposableArchitecture

struct EntryView: View {
    let store: StoreOf<EntryCore>

    var body: some View {
        WithViewStore(store) { viewStore in
            IfLetStore(
                store.scope(state: \.login, action: EntryCore.Action.login),
                then: { loginStore in
                    LoginView(store: loginStore)
                }
            )

            IfLetStore(
                store.scope(state: \.register, action: EntryCore.Action.register),
                then: { registerStore in
                    RegisterView(store: registerStore)
                }
            )
        }
    }
}

struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView(
            store: Store(
                initialState: EntryCore.State(),
                reducer: EntryCore()
            )
        )
    }
}
