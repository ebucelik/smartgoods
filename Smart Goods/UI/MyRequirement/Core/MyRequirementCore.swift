//
//  MyRequirementCore.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 28.12.22.
//

import Foundation
import SwiftHelper
import ComposableArchitecture

class MyRequirementCore: ReducerProtocol {

    struct State: Equatable {
        var requirementsState: Loadable<[Requirement]> = .none
        var requirements: [Requirement] = []
    }

    enum Action: Equatable {
        case fetchRequirements
        case requirementsStateChanged(Loadable<[Requirement]>)
    }

    @Dependency(\.myRequirementService) var service
    @Dependency(\.mainScheduler) var scheduler

    struct DebounceId: Hashable {}

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .fetchRequirements:
            let uuid: String

            if isRunningTest {
                uuid = "uuid"
            } else {
                guard let uuidString = UserDefaults.standard.object(forKey: "uuid") as? String else {
                    return EffectTask(value: .requirementsStateChanged(.error(.notFound)))
                }

                uuid = uuidString
            }

            return EffectTask.run { [self, uuid = uuid] send in
                let requirements = try await service.getRequirements(by: uuid)

                await send(.requirementsStateChanged(.loaded(requirements)))
            } catch: { error, send in
                if let httpError = error as? HTTPError {
                    await send(.requirementsStateChanged(.error(httpError)))
                } else {
                    await send(.requirementsStateChanged(.error(.error(error.localizedDescription))))
                }
            }
            .debounce(id: DebounceId(), for: 1, scheduler: self.scheduler)
            .prepend(.requirementsStateChanged(.loading))
            .eraseToEffect()

        case let .requirementsStateChanged(requirementsState):
            state.requirementsState = requirementsState

            if case let .loaded(requirements) = requirementsState {
                state.requirements = requirements
            }

            return .none
        }
    }
}
