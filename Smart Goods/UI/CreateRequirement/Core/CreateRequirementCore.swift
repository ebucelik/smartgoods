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
        let account: Account

        @BindingState var customRequirement: String
        @BindingState var requirement: String
        
        @BindingState var selectedScheme: Scheme = .rupp
        @BindingState var showCheckAlert: Bool = false

        var requirementSaved: Loadable<CreateRequirementResponse> = .none
        var requirementChecked: Loadable<RequirementResponse> = .none

        var projects: Loadable<[Project]> = .none
        @BindingState var selectedProject: Project

        @BindingState var systemName: String = ""
    }

    enum Action: BindableAction, Equatable {
        case saveRequirement(Scheme)
        case requirementSavedStateChange(Loadable<CreateRequirementResponse>)

        case checkRequirement(Scheme)
        case requirementCheckedStateChange(Loadable<RequirementResponse>)

        case resetState

        case getProjects
        case getProjectsStateChanged(Loadable<[Project]>)

        case binding(BindingAction<State>)
    }
    
    @Dependency(\.createRequirementService) var service
    @Dependency(\.projectService) var projectService
    @Dependency(\.mainScheduler) var scheduler
    
    struct DebounceId: Hashable { }

    var body: some ReducerProtocol<State, Action> {
        BindingReducer()

        Reduce { state, action in
            switch action {
            case let .saveRequirement(scheme):

                let requirement = getRequirement(by: scheme, state)

                let createRequirement = CreateRequirement(
                    projectName: state.systemName,
                    requirement: requirement,
                    username: state.account.username
                )
                
                return EffectTask.run { send in
                    let requirement = try await service.saveRequirement(createRequirement)
                    
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
                    let requirementResponse = try await service.checkRequirement(requirement)
                    
                    await send(.requirementCheckedStateChange(.loaded(requirementResponse)))
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

            case .getProjects:
                if state.account.username.isEmpty {
                    return .none
                }

                return .run { [state = state] send in
                    await send(.getProjectsStateChanged(.loading))

                    let project = try await self.projectService.getProjects(username: state.account.username)

                    await send(.getProjectsStateChanged(.loaded(project)))
                } catch: { error, send in
                    await send(.getProjectsStateChanged(.error(.error(error.localizedDescription))))
                }

            case let .getProjectsStateChanged(getProjectsState):
                state.projects = getProjectsState

                if case let .loaded(projects) = getProjectsState {
                    state.selectedProject = projects.first ?? .empty
                }

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
