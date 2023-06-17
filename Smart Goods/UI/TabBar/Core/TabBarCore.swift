//
//  TabBarCore.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 20.11.22.
//

import Foundation
import ComposableArchitecture

struct TabBarCore: ReducerProtocol {
    struct State: Equatable {
        var account: Account?
        var entry: EntryCore.State = EntryCore.State()
    }

    enum Action: Equatable {
        case entry(EntryCore.Action)
        case checkAccount
    }

    var body: some ReducerProtocol<State, Action> {
        Scope(
            state: \.entry,
            action: /Action.entry
        ) {
            EntryCore()
        }
        
        Reduce { state, action in
            switch action {
            case let .entry(action):

                switch action {
                case let .loaded(account):
                    state.account = account

                default:
                    return .none
                }

                return .none

            case .checkAccount:
                if let accountData = UserDefaults.standard.data(forKey: "account") {
                    do {
                        state.account = try JSONDecoder().decode(Account.self, from: accountData)
                    } catch {
                        print("Decoding failed")
                    }
                }

                return .none
            }
        }
    }
}
