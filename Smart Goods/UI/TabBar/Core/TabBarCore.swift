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
        var uuid: String? = nil
    }

    enum Action: Equatable {
        case checkUuidAvailability(String)
        case createUuid(String)
        case setUuid(String)
    }

    struct Environment {
        // Services
    }

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case let .checkUuidAvailability(forKey):

            guard let uuid = UserDefaults.standard.object(forKey: forKey) as? String else {
                return EffectTask(value: .createUuid(forKey))
            }

            return EffectTask(value: .setUuid(uuid))

        case let .createUuid(forKey):
            let uuid = UUID().uuidString

            UserDefaults.standard.set(uuid, forKey: forKey)

            return EffectTask(value: .setUuid(uuid))

        case let .setUuid(uuid):
            state.uuid = uuid

            return .none
        }
    }
}
