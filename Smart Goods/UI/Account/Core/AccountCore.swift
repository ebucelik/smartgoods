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
        var uuid: Loadable<String> = .none
    }

    enum Action: Equatable {
        case checkIfUuidAvailable(String)
        case uuidStateChanged(uuidState: Loadable<String>)
    }

    struct Environment {

    }

    struct Debouncer: Hashable { }

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case let .checkIfUuidAvailable(key):

            guard let uuid = UserDefaults.standard.object(forKey: key) as? String else {
                return EffectTask(value: .uuidStateChanged(uuidState: .error(.notFound)))
            }

            return EffectTask(value: .uuidStateChanged(uuidState: .loaded(uuid)))
                .debounce(id: Debouncer(), for: 1, scheduler: DispatchQueue.main)
                .prepend(.uuidStateChanged(uuidState: .loading))
                .eraseToEffect()

        case let .uuidStateChanged(uuidState):
            state.uuid = uuidState

            return .none
        }
    }
}
