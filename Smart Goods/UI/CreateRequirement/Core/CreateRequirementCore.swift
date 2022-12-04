//
//  CreateRequirementCore.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 03.12.22.
//

import Foundation
import ComposableArchitecture

struct CreateRequirementCore: ReducerProtocol {
    struct State: Equatable {
        @BindableState var requirement: String
        var requirementSaved: Loadable<Bool> = .none
    }

    enum Action: BindableAction, Equatable {
        case saveRequirement
        case requirementSavedStateChange(Loadable<Bool>)

        case binding(BindingAction<State>)
    }

    struct Environment { }

    var body: some ReducerProtocol<State, Action> {
        BindingReducer()

        Reduce { state, action in
            switch action {
            case .saveRequirement:
                struct DebounceId: Hashable { }

                return EffectTask(
                    value: .requirementSavedStateChange(.loaded(true))
                )
                .debounce(id: DebounceId(), for: 2, scheduler: DispatchQueue.main)
                .prepend(.requirementSavedStateChange(.loading))
                .eraseToEffect()

            case let .requirementSavedStateChange(requirementSavedState):
                state.requirementSaved = requirementSavedState

                return .none

            case .binding:
                return .none
            }
        }
    }
}
