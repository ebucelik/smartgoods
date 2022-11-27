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

    func testSetUuid() async {
        let store = TestStore(
            initialState: TabBarCore.State(),
            reducer: TabBarCore()
        )

        await store.send(.setUuid("uuid")) {
            $0.uuid = "uuid"
        }
    }
}
