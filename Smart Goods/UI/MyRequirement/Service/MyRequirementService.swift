//
//  MyRequirementService.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 28.12.22.
//

import Foundation
import ComposableArchitecture

class MyRequirementService: HTTPClient, MyRequirementServiceProtocol {
    func getProjects(username: String) async throws -> [Project] {
        let call = MyRequirementCall(username: username)

        return try await sendRequest(call: call, responseModel: [Project].self)
    }
}

extension MyRequirementService: DependencyKey {
    static let liveValue: MyRequirementService = MyRequirementService()
    static let testValue: MyRequirementService = MyRequirementServiceMock()
}
