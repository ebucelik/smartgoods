//
//  EditRequirementCore.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 23.06.23.
//

import Foundation
import ComposableArchitecture

class EditRequirementCore: ReducerProtocol {
    struct State: Equatable {
        let id: Int
        @BindingState var editRequirement: EditRequirement
        var editRequirementState: Loadable<EditRequirementResponse> = .none
    }

    enum Action: BindableAction, Equatable {
        case editRequirement
        case editRequirementStateChanged(Loadable<EditRequirementResponse>)

        case binding(BindingAction<State>)
    }

    @Dependency(\.myRequirementService) var service
    @Dependency(\.mainScheduler) var scheduler

    struct DebounceId: Hashable {}

    var body: some ReducerProtocol<State, Action> {
        BindingReducer()

        Reduce { state, action in
            switch action {
            case .editRequirement:
                if state.editRequirement.requirement.isEmpty {
                    return .none
                }

                return .run { [state = state] send in
                    let editRequirementResponse = try await self.service.editRequirement(
                        id: state.id,
                        editRequirement: state.editRequirement
                    )

                    await send(.editRequirementStateChanged(.loaded(editRequirementResponse)))
                } catch: { error, send in
                    if let httpError = error as? HTTPError {
                        await send(.editRequirementStateChanged(.error(httpError)))
                    } else {
                        await send(.editRequirementStateChanged(.error(.error(error.localizedDescription))))
                    }
                }
                .debounce(id: DebounceId(), for: 0.4, scheduler: self.scheduler)
                .prepend(.editRequirementStateChanged(.loading))
                .eraseToEffect()

            case let .editRequirementStateChanged(editRequirementState):
                state.editRequirementState = editRequirementState

                return .none

            case .binding:
                return .none
            }
        }
    }
}
