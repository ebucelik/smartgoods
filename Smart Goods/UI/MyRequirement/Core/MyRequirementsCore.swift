//
//  MyRequirementsCore.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 23.06.23.
//

import Foundation
import ComposableArchitecture

class MyRequirementsCore: ReducerProtocol {

    struct State: Equatable {
        static func == (lhs: MyRequirementsCore.State, rhs: MyRequirementsCore.State) -> Bool {
            lhs.account == rhs.account &&
            lhs.project == rhs.project &&
            lhs.showHintAlert == rhs.showHintAlert &&
            lhs.projectState == rhs.projectState &&
            lhs.editRequirement == rhs.editRequirement &&
            lhs.requirement == rhs.requirement
        }

        let account: Account
        var projectState: Loadable<Project> = .none
        var project: Project
        var onDismiss: () -> Void

        @PresentationState var editRequirement: EditRequirementCore.State? = nil
        @BindingState var showHintAlert: Bool = false
        var requirement: Requirement = .empty
    }

    enum Action: BindableAction, Equatable {
        case fetchProjects
        case projectsStateChanged(Loadable<Project>)

        case deleteRequirement(Int)
        case deleteRequirementStateChanged(Loadable<Info>)

        case showEditRequirementView(String, Requirement)
        case editRequirement(PresentationAction<EditRequirementCore.Action>)

        case showHint(Requirement)
        case binding(BindingAction<State>)

        case onDismiss
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

                    guard let project = projects.first(where: { $0.id == state.project.id }) else { return }

                    await send(.projectsStateChanged(.loaded(project)))
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

            case let .projectsStateChanged(projectState):
                state.projectState = projectState

                if case let .loaded(project) = projectState {
                    state.project = project
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

            case .onDismiss:
                state.onDismiss()

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

