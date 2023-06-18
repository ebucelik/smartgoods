//
//  NewPasswordCore.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 18.06.23.
//

import Foundation
import ComposableArchitecture

class NewPasswordCore: ReducerProtocol {
    struct State: Equatable {
        let account: Account
        var info: Loadable<Info> = .none
        @BindingState var newPassword: NewPassword = .empty
    }

    enum Action: BindableAction, Equatable {
        case changePassword
        case changePasswordStateChanged(Loadable<Info>)
        case binding(BindingAction<State>)
    }

    @Dependency(\.accountService) var service

    var body: some ReducerProtocol<State, Action> {
        BindingReducer()

        Reduce { state, action in
            switch action {
            case .changePassword:

                if state.newPassword.controlNewPassword.isEmpty || state.newPassword.newPassword.isEmpty || state.newPassword.oldPassword.isEmpty {
                    return .none
                }

                if state.newPassword.controlNewPassword != state.newPassword.newPassword {
                    return .none
                }

                return .run { [state = state] send in
                    await send(.changePasswordStateChanged(.loading))

                    try await Task.sleep(for: .seconds(1))

                    let info = try await self.service.changePassword(
                        username: state.account.username,
                        newPassword: state.newPassword
                    )

                    await send(.changePasswordStateChanged(.loaded(info)))
                } catch: { error, send in
                    await send(.changePasswordStateChanged(.error(.error(error.localizedDescription))))
                }

            case let .changePasswordStateChanged(infoState):
                state.info = infoState

                return .none

            case .binding:
                return .none
            }
        }
    }
}
