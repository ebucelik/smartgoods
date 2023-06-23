//
//  MyRequirementCore.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 28.12.22.
//

import Foundation
import ComposableArchitecture

class MyRequirementCore: ReducerProtocol {

    struct State: Equatable {
        let account: Account
        var projectsState: Loadable<[Project]> = .none
        var projects: [Project] = []

        @PresentationState var editRequirement: EditRequirementCore.State? = nil
        @BindingState var showHintAlert: Bool = false
        var requirement: Requirement = .empty
    }

    enum Action: BindableAction, Equatable {
        case fetchProjects
        case projectsStateChanged(Loadable<[Project]>)

        case deleteRequirement(Int)
        case deleteRequirementStateChanged(Loadable<Info>)

        case showEditRequirementView(String, Requirement)
        case editRequirement(PresentationAction<EditRequirementCore.Action>)

        case showHint(Requirement)
        case binding(BindingAction<State>)
    }

    @Dependency(\.myRequirementService) var service
    @Dependency(\.mainScheduler) var scheduler

    struct DebounceId: Hashable {}

    var body: some ReducerProtocol<State, Action> {
        BindingReducer()

        Reduce { state, action in
            switch action {
            case .fetchProjects:
                if state.account.username.isEmpty {
                    return .none
                }

                return EffectTask.run { [state = state] send in
                    let projects = try await self.service.getProjects(username: state.account.username)

                    await send(.projectsStateChanged(.loaded(projects)))
                } catch: { error, send in
                    if let httpError = error as? HTTPError {
                        await send(.projectsStateChanged(.error(httpError)))
                    } else {
                        await send(.projectsStateChanged(.error(.error(error.localizedDescription))))
                    }
                }
                .debounce(id: DebounceId(), for: 0.4, scheduler: self.scheduler)
                .prepend(.projectsStateChanged(.loading))
                .eraseToEffect()

            case let .projectsStateChanged(projectsState):
                state.projectsState = projectsState

                if case let .loaded(projects) = projectsState {
                    state.projects = projects
                }

                return .none

            case let .deleteRequirement(id):
                return .run { send in
                    let info = try await self.service.deleteRequirement(id: id)

                    await send(.deleteRequirementStateChanged(.loaded(info)))
                } catch: { error, send in
                    if let httpError = error as? HTTPError {
                        await send(.deleteRequirementStateChanged(.error(httpError)))
                    } else {
                        await send(.deleteRequirementStateChanged(.error(.error(error.localizedDescription))))
                    }
                }
                .debounce(id: DebounceId(), for: 0.4, scheduler: self.scheduler)
                .prepend(.deleteRequirementStateChanged(.loading))
                .eraseToEffect()

            case let .deleteRequirementStateChanged(deleteRequirementState):
                if case .loaded = deleteRequirementState {
                    return .send(.fetchProjects)
                }

                return .none

            case let .showEditRequirementView(projectName, requirement):
                state.editRequirement = EditRequirementCore.State(
                    id: requirement.id,
                    editRequirement: EditRequirement(
                        projectName: projectName,
                        requirement: requirement.requirement
                    )
                )

                return .none

            case .editRequirement(.dismiss):
                return .none

            case let .editRequirement(.presented(action)):
                if case .editRequirementStateChanged(.loaded) = action {
                    state.editRequirement = nil

                    return .send(.fetchProjects)
                }

                return .none

            case let .showHint(requirement):
                state.requirement = requirement
                state.showHintAlert = true

                return .none

            case .binding:
                return .none
            }
        }
        .ifLet(
            \.$editRequirement,
             action: /Action.editRequirement
        ) {
            EditRequirementCore()
        }
    }
}
