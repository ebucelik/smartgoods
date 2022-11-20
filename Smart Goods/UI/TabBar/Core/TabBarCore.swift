//
//  TabBarCore.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 20.11.22.
//

import ComposableArchitecture

struct TabBarCore: ReducerProtocol {
    struct State: Equatable {
        var isUuidAvailable: Bool? = nil
    }

    enum Action: Equatable {
        case checkUuidAvailability(String)
        case setUuidAvailability(Bool)
    }

    struct Environment {
        // Services
    }

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case let .checkUuidAvailability(forKey):

            // TODO: To be implemented...

            return EffectTask(value: .setUuidAvailability(true))

        case let .setUuidAvailability(isUuidAvailable):
            state.isUuidAvailable = isUuidAvailable

            return .none
        }
    }
}
