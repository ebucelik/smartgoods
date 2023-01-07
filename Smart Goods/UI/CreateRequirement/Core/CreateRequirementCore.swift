//
//  CreateRequirementCore.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 03.12.22.
//

import Foundation
import ComposableArchitecture

struct CreateRequirementCore: ReducerProtocol {
    
    enum Scheme: String, CaseIterable, Identifiable {
        case rupp = "Rupp's scheme"
        case none = "No scheme"

        var id: Self { self }
    }
    
    struct State: Equatable {
        @BindableState var customRequirement: String
        @BindableState var requirement: String
        
        @BindableState var selectedScheme: Scheme = .rupp
        @BindableState var showCheckAlert: Bool = false

        var requirementSaved: Loadable<Message> = .none
        var requirementChecked: Loadable<Bool> = .none
    }

    enum Action: BindableAction, Equatable {
        case saveRequirement(Scheme)
        case requirementSavedStateChange(Loadable<Message>)

        case checkRequirement(Scheme)
        case requirementCheckedStateChange(Loadable<Bool>)

        case resetState

        case binding(BindingAction<State>)
    }
    
    @Dependency(\.createRequirementService) var service
    @Dependency(\.mainScheduler) var scheduler
    
    struct DebounceId: Hashable { }

    var body: some ReducerProtocol<State, Action> {
        BindingReducer()

        Reduce { state, action in
            switch action {
            case let .saveRequirement(scheme):

                let requirement = getRequirement(by: scheme, state)
                let uuid = getUuid()
                
                return EffectTask.run { send in
                    let requirement = try await service.saveRequirement(requirement, for: uuid)
                    
                    await send(.requirementSavedStateChange(.loaded(requirement)))
                } catch: { error, send in
                    await send(.requirementSavedStateChange(.error(.error(error.localizedDescription))))
                }
                .debounce(id: DebounceId(), for: 1, scheduler: self.scheduler)
                .prepend(.requirementSavedStateChange(.loading))
                .eraseToEffect()

            case let .requirementSavedStateChange(requirementSavedState):
                state.requirementSaved = requirementSavedState

                return .none

            case let .checkRequirement(scheme):

                let requirement = getRequirement(by: scheme, state)
                
                return EffectTask.run { send in
                    let isValid = try await service.checkRequirement(requirement)
                    
                    await send(.requirementCheckedStateChange(.loaded(isValid)))
                } catch: { error, send in
                    await send(.requirementCheckedStateChange(.error(.error(error.localizedDescription))))
                }
                .debounce(id: DebounceId(), for: 1, scheduler: self.scheduler)
                .prepend(.requirementCheckedStateChange(.loading))
                .eraseToEffect()

            case let .requirementCheckedStateChange(requirementCheckedState):
                state.requirementChecked = requirementCheckedState

                return .none

            case .resetState:
                state.requirementSaved = .none
                state.requirementChecked = .none

                return .none

            case .binding:
                return .none
            }
        }
    }

    private func getRequirement(by scheme: Scheme, _ state: State) -> String {
        switch scheme {
        case .rupp:
            return state.requirement
        case .none:
            return state.customRequirement
        }
    }

    private func getUuid() -> String {
        return UserDefaults.standard.object(forKey: "uuid") as? String ?? ""
    }
}
