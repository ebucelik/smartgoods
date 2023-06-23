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
    }

    enum Action: Equatable {
        case fetchProjects
        case projectsStateChanged(Loadable<[Project]>)
    }

    @Dependency(\.myRequirementService) var service
    @Dependency(\.mainScheduler) var scheduler

    struct DebounceId: Hashable {}

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
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
        }
    }
}
