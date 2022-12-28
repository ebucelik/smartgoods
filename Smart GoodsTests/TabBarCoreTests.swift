//
//  TabBarCoreTests.swift
//  Smart GoodsTests
//
//  Created by Ing. Ebu Celik, BSc on 24.11.22.
//

import XCTest
@testable import Smart_Goods
import ComposableArchitecture

@MainActor
final class TabBarCoreTests: XCTestCase {

    func testUuidAvailability() async {
        // Arrange
        let store = TestStore(
            initialState: TabBarCore.State(),
            reducer: TabBarCore()
        )
        let expectedUuid = "uuid"

        store.dependencies.tabBarService = .testValue
        store.dependencies.mainScheduler = .testValue

        // Act
        await store.send(.checkUuidAvailability(expectedUuid))

        await store.receive(.createUuid(expectedUuid))
        await store.receive(.createRemoteUser(expectedUuid))
        await store.receive(.uuidStateChanged(.loading)) { state in
            //Assert
            state.uuidState = .loading
        }

        _ = XCTWaiter.wait(for: [expectation(description: "loading")], timeout: 1)

        await store.receive(.uuidStateChanged(.loaded(expectedUuid))) { state in
            //Assert
            state.uuidState = .loaded(expectedUuid)
        }

        await store.finish()
    }
}
