//
//  EditProjectCore.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 22.06.23.
//

import Foundation
import ComposableArchitecture

class EditProjectCore: ReducerProtocol {
    struct State: Equatable {
        @BindingState var editProject: UpdateProjectName
        var editProjectState: Loadable<Project> = .none
        let account: Account
    }

    enum Action: BindableAction, Equatable {
        case editProject
        case editProjectStateChanged(Loadable<Project>)
        case binding(BindingAction<State>)
    }

    @Dependency(\.projectService) var service
    @Dependency(\.continuousClock) var clock

    var body: some ReducerProtocol<State, Action> {
        BindingReducer()

        Reduce { state, action in
            switch action {
            case .editProject:
                if state.editProject.newProjectName.isEmpty || state.account.username.isEmpty {
                    return .none
                }

                return .run { [state = state] send in
                    await send(.editProjectStateChanged(.loading))

                    try await self.clock.sleep(for: .seconds(1))

                    let project = try await self.service.updateProjectName(
                        username: state.account.username,
                        state.editProject
                    )

                    await send(.editProjectStateChanged(.loaded(project)))
                } catch: { error, send in
                    await send(.editProjectStateChanged(.error(.error(error.localizedDescription))))
                }

            case let .editProjectStateChanged(editProjectState):
                state.editProjectState = editProjectState

                return .none

            case .binding:
                return .none
            }
        }
    }
}
