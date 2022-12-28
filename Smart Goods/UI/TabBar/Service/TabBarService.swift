//
//  TabBarServiceProtocol.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 28.12.22.
//

import ComposableArchitecture

class TabBarService: HTTPClient, TabBarServiceProtocol {
    func setUuid(with uuid: String) async throws {
        var call = UuidCall()
        call.path.append(uuid)

        _ = try await sendRequest(call: call, responseModel: String.self, noResponse: true)
    }
}

extension TabBarService: DependencyKey {
    static let liveValue: TabBarService = TabBarService()
}
