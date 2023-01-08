//
//  CreateRequirementCoreTests.swift
//  Smart GoodsTests
//
//  Created by Ing. Ebu Celik, BSc on 04.12.22.
//

import XCTest
@testable import Smart_Goods
import ComposableArchitecture

@MainActor
final class CreateRequirementCoreTests: XCTestCase {
    func testSaveRequirement() async {
        //Act
        let store = TestStore(
            initialState: CreateRequirementCore.State(
                customRequirement: "",
                requirement: ""
            ),
            reducer: CreateRequirementCore()
        )
        let expectedMessage = Message.mockSuccess

        //Arrange
        await store.send(.saveRequirement(.rupp))

        _ = XCTWaiter.wait(for: [expectation(description: "loading")], timeout: 1.0)

        await store.receive(.requirementSavedStateChange(.loading)) {
            //Assert
            $0.requirementSaved = .loading
        }

        await store.receive(.requirementSavedStateChange(.loaded(expectedMessage))) {
            //Assert
            $0.requirementSaved = .loaded(expectedMessage)
        }

        await store.finish()
    }

    func testCheckRequirement() async {
        //Act
        let store = TestStore(
            initialState: CreateRequirementCore.State(
                customRequirement: "",
                requirement: ""
            ),
            reducer: CreateRequirementCore()
        )
        let mockCheck = true

        //Arrange
        await store.send(.checkRequirement(.rupp))

        _ = XCTWaiter.wait(for: [expectation(description: "loading")], timeout: 1.0)

        await store.receive(.requirementCheckedStateChange(.loading)) {
            //Assert
            $0.requirementChecked = .loading
        }

        await store.receive(.requirementCheckedStateChange(.loaded(mockCheck))) {
            //Assert
            $0.requirementChecked = .loaded(mockCheck)
        }

        await store.finish()
    }

    func testReset() async {
        //Act
        let store = TestStore(
            initialState: CreateRequirementCore.State(
                customRequirement: "",
                requirement: ""
            ),
            reducer: CreateRequirementCore()
        )
        let mockMessage = Message.mockSuccess
        let mockCheck = true

        //Arrange
        await store.send(.requirementSavedStateChange(.loaded(mockMessage))) {
            //Assert
            $0.requirementSaved = .loaded(mockMessage)
        }

        await store.send(.requirementCheckedStateChange(.loaded(mockCheck))) {
            //Assert
            $0.requirementChecked = .loaded(mockCheck)
        }

        await store.send(.resetState) {
            //Assert
            $0.requirementSaved = .none
            $0.requirementChecked = .none
        }

        await store.finish()
    }
}
