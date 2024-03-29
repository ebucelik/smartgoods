//
//  LoginCore.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 16.06.23.
//

import ComposableArchitecture

struct LoginCore: ReducerProtocol {
    struct State: Equatable {
        @BindingState var login: Login = .empty
        var account: Loadable<Account> = .none
    }

    enum Action: BindableAction, Equatable {
        case login
        case accountStateChanged(Loadable<Account>)
        case showRegister
        case binding(BindingAction<State>)
    }

    @Dependency(\.loginService) var service
    @Dependency(\.mainScheduler) var mainScheduler

    struct DebounceId: Hashable {}

    var body: some ReducerProtocol<State, Action> {
        BindingReducer()

        Reduce { state, action in
            switch action {
            case .login:
                if state.login.username.isEmpty || state.login.password.isEmpty {
                    return .none
                }

                return .run { [state = state] send in
                    await send(.accountStateChanged(.loading))

                    try await Task.sleep(for: .seconds(1))

                    let account = try await self.service.login(state.login)

                    await send(.accountStateChanged(.loaded(account)))
                } catch: { error, send in
                    await send(.accountStateChanged(.error(.error(error.localizedDescription))))
                }

            case let .accountStateChanged(accountState):
                state.account = accountState

                return .none

            case .showRegister:
                return .none

            case .binding:
                return .none
            }
        }
    }
}
