//
//  LoginCore.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 16.06.23.
//

import ComposableArchitecture

struct LoginCore: ReducerProtocol {
    struct State: Equatable {
        @BindableState var account: Account = .empty
    }

    enum Action: BindableAction, Equatable {
        case login
        case binding(BindingAction<State>)
    }

    var body: some ReducerProtocol<State, Action> {
        BindingReducer()

        Reduce { state, action in
            switch action {
            case .login:
                return .none

            case .binding:
                return .none
            }
        }
    }
}
