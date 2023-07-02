//
//  MyRequirementCoreTests.swift
//  Smart GoodsTests
//
//  Created by Ing. Ebu Celik, BSc on 29.12.22.
//

import Foundation
@testable import Smart_Goods
import ComposableArchitecture
import XCTest

@MainActor
final class MyRequirementCoreTests: XCTestCase {

    func testFetchProjects() async {
        // Act
        let store = TestStore(
            initialState: MyRequirementCore.State(account: .mock),
            reducer: MyRequirementCore()
        ) {
            $0.myRequirementService = .testValue
            $0.mainScheduler = .testValue
        }
        let expectedProjects = [Project.mock]

        // Arrange
        await store.send(.fetchProjects)

        await store.receive(.projectsStateChanged(.loading)) {
            $0.projectsState = .loading
        }

        _ = await XCTWaiter.fulfillment(
            of: [XCTestExpectation(description: "")],
            timeout: 2
        )

        await store.receive(
            .projectsStateChanged(
                .loaded(
                    expectedProjects
                )
            )
        ) { state in
            // Assert
            state.projectsState = .loaded(expectedProjects)
            state.projects = expectedProjects
        }
    }

    func testDeleteRequirement() async {
        // Act
        let store = TestStore(
            initialState: MyRequirementCore.State(account: .mock),
            reducer: MyRequirementCore()
        ) {
            $0.myRequirementService = .testValue
            $0.mainScheduler = .testValue
        }

        store.exhaustivity = .off

        // Arrange
        await store.send(.deleteRequirement(1))

        await store.receive(.deleteRequirementStateChanged(.loading))

        _ = await XCTWaiter.fulfillment(
            of: [XCTestExpectation(description: "")],
            timeout: 2
        )

        await store.receive(
            .deleteRequirementStateChanged(
                .loaded(
                    .mockSuccess
                )
            )
        )

        await store.receive(.fetchProjects)
    }

    func testShowHint() async {
        // Act
        let store = TestStore(
            initialState: MyRequirementCore.State(account: .mock),
            reducer: MyRequirementCore()
        ) {
            $0.myRequirementService = .testValue
            $0.mainScheduler = .testValue
        }
        let expectedRequirement = Requirement.mockRequirement

        // Arrange & Assert
        await store.send(.showHint(expectedRequirement)) {
            $0.requirement = expectedRequirement
            $0.showHintAlert = true
        }
    }

    func testShowEditRequirementView() async {
        // Act
        let store = TestStore(
            initialState: MyRequirementCore.State(account: .mock),
            reducer: MyRequirementCore()
        ) {
            $0.myRequirementService = .testValue
            $0.mainScheduler = .testValue
        }
        let mockRequirement = Requirement.mockRequirement
        let mockProjectName = "The boring company"
        let expectedEditRequirement = EditRequirementCore.State(
            id: mockRequirement.id,
            editRequirement: EditRequirement(
                projectName: mockProjectName,
                requirement: mockRequirement.requirement
            )
        )

        // Arrange & Assert
        await store.send(.showEditRequirementView(mockProjectName, mockRequirement)) {
            $0.editRequirement = expectedEditRequirement
        }
    }
}
