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
    }

    enum Action {
        case fetchRequirements
        case requirementsStateChanged(Loadable<[Requirement]>)
    }

    @Dependency(\.myRequirementService) var service
    @Dependency(\.mainScheduler) var scheduler

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .fetchRequirements:
            guard let uuid = UserDefaults.standard.object(forKey: "uuid") as? String else {
                return EffectTask(value: .requirementsStateChanged(.error(.notFound)))
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
            .prepend(.requirementsStateChanged(.loading))
            .eraseToEffect()

        case let .requirementsStateChanged(requirementsState):
            state.requirementsState = requirementsState

            return .none
        }
    }
}
