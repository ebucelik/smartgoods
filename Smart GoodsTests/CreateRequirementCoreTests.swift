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
        let store = TestStore(
            initialState: CreateRequirementCore.State(
                customRequirement: "",
                requirement: ""
            ),
            reducer: CreateRequirementCore()
        )

        await store.send(.saveRequirement(.rupp))

        _ = XCTWaiter.wait(for: [expectation(description: "loading")], timeout: 1.0)

        await store.receive(.requirementSavedStateChange(.loading)) {
            $0.requirementSaved = .loading
        }

        await store.receive(.requirementSavedStateChange(.loaded(true))) {
            $0.requirementSaved = .loaded(true)
        }

        await store.finish()
    }

    func testCheckRequirement() async {
        let store = TestStore(
            initialState: CreateRequirementCore.State(
                customRequirement: "",
                requirement: ""
            ),
            reducer: CreateRequirementCore()
        )

        await store.send(.checkRequirement(.rupp))

        _ = XCTWaiter.wait(for: [expectation(description: "loading")], timeout: 1.0)

        await store.receive(.requirementCheckedStateChange(.loading)) {
            $0.requirementChecked = .loading
        }

        await store.receive(.requirementCheckedStateChange(.loaded(true))) {
            $0.requirementChecked = .loaded(true)
        }

        await store.finish()
    }
}
