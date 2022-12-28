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

    func testFetchRequirements() async {
        //Act
        let store = TestStore(
            initialState: MyRequirementCore.State(),
            reducer: MyRequirementCore()
        )
        let expectedRequirements = Requirement.mockRequirements

        //Arrange
        await store.send(.fetchRequirements)

        await store.receive(.requirementsStateChanged(.loading)) { state in
            //Assert
            state.requirementsState = .loading
        }

        _ = XCTWaiter.wait(for: [expectation(description: "loading")], timeout: 1)

        await store.receive(.requirementsStateChanged(.loaded(expectedRequirements))) {
            state in
            //Assert
            state.requirementsState = .loaded(expectedRequirements)
        }
    }
}
