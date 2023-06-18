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
        var accountState: AccountCore.State?
    }

    enum Action: Equatable {
        case entry(EntryCore.Action)
        case account(AccountCore.Action)
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
                    state.accountState = AccountCore.State(account: account)
                    state.account = account

                default:
                    return .none
                }

                return .none

            case .checkAccount:
                if let accountData = UserDefaults.standard.data(forKey: "account") {
                    do {
                        let account = try JSONDecoder().decode(Account.self, from: accountData)
                        state.accountState = AccountCore.State(account: account)
                        state.account = account
                    } catch {
                        print("Decoding failed")
                    }
                }

                return .none

            case let .account(action):
                if case .logout = action {
                    state.accountState = nil
                    state.entry = EntryCore.State()
                    UserDefaults.removeAllDataFromUserDefaults()
                    state.account = nil
                }

                return .none
            }
        }
        .ifLet(
            \.accountState,
             action: /Action.account
        ) {
            AccountCore()
        }
    }
}
