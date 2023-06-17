//
//  EntryCore.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 17.06.23.
//

import ComposableArchitecture
import Foundation

class EntryCore: ReducerProtocol {
    struct State: Equatable {
        var login: LoginCore.State? = LoginCore.State()
        var register: RegisterCore.State?
    }

    enum Action: Equatable {
        case login(LoginCore.Action)
        case register(RegisterCore.Action)
        case loaded(Account)
    }

    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case let .login(action):

                if case .showRegister = action {
                    state.login = nil
                    state.register = RegisterCore.State()
                }

                if case let .accountStateChanged(.loaded(account)) = action {
                    do {
                        let accountData = try JSONEncoder().encode(account)

                        UserDefaults.standard.set(accountData, forKey: "account")
                    } catch {
                        print("Encoding failed")
                    }

                    return .send(.loaded(account))
                }

                return .none

            case let .register(action):

                if case .showLogin = action {
                    state.register = nil
                    state.login = LoginCore.State()
                }

                if case let .accountStateChanged(.loaded(account)) = action {
                    do {
                        let accountData = try JSONEncoder().encode(account)

                        UserDefaults.standard.set(accountData, forKey: "account")
                    } catch {
                        print("Encoding failed")
                    }

                    return .send(.loaded(account))
                }

                return .none

            case .loaded:
                return .none
            }
        }
        .ifLet(
            \.login,
             action: /Action.login
        ) {
            LoginCore()
        }
        .ifLet(
            \.register,
             action: /Action.register
        ) {
            RegisterCore()
        }
    }
}
