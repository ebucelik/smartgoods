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
        @BindableState var customRequirement: String
        @BindableState var requirement: String

        var requirementSaved: Loadable<Bool> = .none
        var requirementChecked: Loadable<Bool> = .none
    }

    enum Action: BindableAction, Equatable {
        case saveRequirement(CreateRequirementView.Scheme)
        case requirementSavedStateChange(Loadable<Bool>)

        case checkRequirement(CreateRequirementView.Scheme)
        case requirementCheckedStateChange(Loadable<Bool>)

        case binding(BindingAction<State>)
    }

    struct Environment { }

    struct DebounceId: Hashable { }

    var body: some ReducerProtocol<State, Action> {
        BindingReducer()

        Reduce { state, action in
            switch action {
            case let .saveRequirement(scheme):

                let requirement = getRequirement(by: scheme, state)

                // TODO: do backend call
                return EffectTask(
                    value: .requirementSavedStateChange(.loaded(true))
                )
                .debounce(id: DebounceId(), for: 1, scheduler: DispatchQueue.main)
                .prepend(.requirementSavedStateChange(.loading))
                .eraseToEffect()

            case let .requirementSavedStateChange(requirementSavedState):
                state.requirementSaved = requirementSavedState

                return .none

            case let .checkRequirement(scheme):

                let requirement = getRequirement(by: scheme, state)

                // TODO: do backend call
                return EffectTask(
                    value: .requirementCheckedStateChange(.loaded(true))
                )
                .debounce(id: DebounceId(), for: 1, scheduler: DispatchQueue.main)
                .prepend(.requirementCheckedStateChange(.loading))
                .eraseToEffect()

            case let .requirementCheckedStateChange(requirementCheckedState):
                state.requirementChecked = requirementCheckedState

                return .none

            case .binding:
                return .none
            }
        }
    }

    private func getRequirement(by scheme: CreateRequirementView.Scheme, _ state: State) -> String {
        switch scheme {
        case .rupp:
            return state.requirement
        case .none:
            return state.customRequirement
        }
    }
}
