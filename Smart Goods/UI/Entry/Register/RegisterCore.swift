//
//  RegisterCore.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 17.06.23.
//

import ComposableArchitecture

struct RegisterCore: ReducerProtocol {
    struct State: Equatable {
        @BindingState var register: Register = .empty
        var account: Loadable<Account> = .none
    }

    enum Action: BindableAction, Equatable {
        case register
        case accountStateChanged(Loadable<Account>)
        case showLogin
        case binding(BindingAction<State>)
    }

    @Dependency(\.registerService) var service
    @Dependency(\.mainScheduler) var mainScheduler

    struct DebounceId: Hashable {}

    var body: some ReducerProtocol<State, Action> {
        BindingReducer()

        Reduce { state, action in
            switch action {
            case .register:
                if state.register.username.isEmpty || state.register.password.isEmpty {
                    return .none
                }

                return .run { [state = state] send in
                    await send(.accountStateChanged(.loading))

                    let account = try await self.service.register(state.register)

                    await send(.accountStateChanged(.loaded(account)))
                } catch: { error, send in
                    await send(.accountStateChanged(.error(.error(error.localizedDescription))))
                }
                .debounce(id: DebounceId(), for: 1, scheduler: self.mainScheduler)

            case let .accountStateChanged(accountState):
                state.account = accountState

                return .none

            case .showLogin:
                return .none

            case .binding:
                return .none
            }
        }
    }
}

