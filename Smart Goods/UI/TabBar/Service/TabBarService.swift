//
//  TabBarServiceProtocol.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 28.12.22.
//

import ComposableArchitecture

class TabBarService: HTTPClient, TabBarServiceProtocol {
    func setUuid(with uuid: String) async throws {
        let register = Register(uuid: uuid)
        let call = UuidCall(httpBody: register)

        _ = try await sendRequest(call: call, responseModel: Message.self)
    }
}

extension TabBarService: DependencyKey {
    static let liveValue: TabBarService = TabBarService()
    static let testValue: TabBarService = TabBarServiceMock()
}
