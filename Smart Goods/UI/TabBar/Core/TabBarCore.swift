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
        var uuidState: Loadable<String> = .none
    }

    enum Action: Equatable {
        case checkUuidAvailability(String)
        case createUuid(String)
        case createRemoteUser(String)
        case uuidStateChanged(Loadable<String>)
    }

    @Dependency(\.tabBarService) var service
    @Dependency(\.mainScheduler) var scheduler

    struct DebounceId: Hashable {}

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case let .checkUuidAvailability(forKey):

            guard let uuid = UserDefaults.standard.object(forKey: forKey) as? String else {
                return EffectTask(value: .createUuid(forKey))
            }

            return EffectTask(value: .uuidStateChanged(.loaded(uuid)))

        case let .createUuid(forKey):
            let uuid = UUID().uuidString

            UserDefaults.standard.set(uuid, forKey: forKey)

            return EffectTask(value: .createRemoteUser(uuid))

        case let .createRemoteUser(uuid):

            return EffectTask.run { [uuid = uuid] send in
                try await service.setUuid(with: uuid)

                await send(.uuidStateChanged(.loaded(uuid)))
            } catch: { error, send in
                if let httpError = error as? HTTPError {
                    await send(.uuidStateChanged(.error(httpError)))
                } else {
                    await send(.uuidStateChanged(.error(.error(error.localizedDescription))))
                }
            }
            .debounce(id: DebounceId(), for: 1, scheduler: self.scheduler)
            .prepend(.uuidStateChanged(.loading))
            .eraseToEffect()

        case let .uuidStateChanged(uuidState):
            state.uuidState = uuidState

            return .none
        }
    }
}
