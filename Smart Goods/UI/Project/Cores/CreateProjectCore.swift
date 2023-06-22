//
//  CreateProjectCore.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 22.06.23.
//

import Foundation
import ComposableArchitecture

class CreateProjectCore: ReducerProtocol {
    struct State: Equatable {
        @BindingState var createProject: CreateProject = .empty
        var createProjectState: Loadable<Project> = .none
        var projects: Loadable<[Project]> = .none
        let account: Account

        @PresentationState var editProject: EditProjectCore.State? = nil
    }

    enum Action: BindableAction, Equatable {
        case createProject
        case createProjectStateChanged(Loadable<Project>)
        case deleteProject(Int)
        case getProjects
        case getProjectsStateChanged(Loadable<[Project]>)
        case binding(BindingAction<State>)
        case showEditProjectView(Project)
        case editProject(PresentationAction<EditProjectCore.Action>)
    }

    @Dependency(\.projectService) var service
    @Dependency(\.continuousClock) var clock

    var body: some ReducerProtocol<State, Action> {
        BindingReducer()

        Reduce { state, action in
            switch action {
            case .createProject:
                state.createProject.username = state.account.username

                if state.createProject.projectName.isEmpty || state.createProject.username.isEmpty {
                    return .none
                }

                return .run { [state = state] send in
                    await send(.createProjectStateChanged(.loading))

                    try await self.clock.sleep(for: .seconds(1))

                    let project = try await self.service.createProject(state.createProject)

                    await send(.createProjectStateChanged(.loaded(project)))
                } catch: { error, send in
                    await send(.createProjectStateChanged(.error(.error(error.localizedDescription))))
                }

            case let .createProjectStateChanged(createProjectState):
                state.createProjectState = createProjectState

                if case .loaded = createProjectState {
                    state.createProject = .empty

                    return .send(.getProjects)
                }

                return .none

            case let .deleteProject(id):
                if state.account.username.isEmpty {
                    return .none
                }

                return .run { [state = state] send in
                    await send(.getProjectsStateChanged(.loading))

                    try await self.clock.sleep(for: .seconds(1))

                    _ = try await self.service.deleteProject(id)
                    let project = try await self.service.getProjects(username: state.account.username)

                    await send(.getProjectsStateChanged(.loaded(project)))
                } catch: { error, send in
                    await send(.getProjectsStateChanged(.error(.error(error.localizedDescription))))
                }

            case .getProjects:
                if state.account.username.isEmpty {
                    return .none
                }

                return .run { [state = state] send in
                    await send(.getProjectsStateChanged(.loading))

                    try await self.clock.sleep(for: .seconds(1))

                    let project = try await self.service.getProjects(username: state.account.username)

                    await send(.getProjectsStateChanged(.loaded(project)))
                } catch: { error, send in
                    await send(.getProjectsStateChanged(.error(.error(error.localizedDescription))))
                }

            case let .getProjectsStateChanged(getProjectsState):
                state.projects = getProjectsState

                return .none

            case .binding:
                return .none

            case let .showEditProjectView(project):
                state.editProject = EditProjectCore.State(
                    editProject: UpdateProjectName(
                        newProjectName: "",
                        oldProjectName: project.projectName
                    ),
                    account: state.account
                )

                return .none

            case let .editProject(.presented(editProjectAction)):
                if case .editProjectStateChanged(.loaded) = editProjectAction {
                    state.editProject = nil
                    
                    return .send(.getProjects)
                }

                return .none

            case .editProject(.dismiss):
                return .none
            }
        }
        .ifLet(
            \.$editProject,
             action: /Action.editProject
        ) {
            EditProjectCore()
        }
    }
}
