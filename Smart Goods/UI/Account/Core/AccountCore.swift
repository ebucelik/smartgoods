//
//  AccountCore.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 17.12.22.
//

import Foundation
import ComposableArchitecture

struct AccountCore: ReducerProtocol {
    struct State: Equatable {
        let account: Account
        @PresentationState var newPassword: NewPasswordCore.State?
    }

    enum Action: Equatable {
        case logout
        case showNewPassword
        case newPassword(PresentationAction<NewPasswordCore.Action>)
    }

    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .logout:
                return .none

            case .showNewPassword:
                state.newPassword = NewPasswordCore.State(account: state.account)

                return .none

            case .newPassword(.dismiss):
                return .none

            case let .newPassword(.presented(action)):
                if case .changePasswordStateChanged(.loaded) = action {
                    state.newPassword = nil
                }

                return .none
            }
        }
        .ifLet(
            \.$newPassword,
             action: /Action.newPassword
        ) {
            NewPasswordCore()
        }
    }
}
