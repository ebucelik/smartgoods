//
//  MyRequirementService.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 28.12.22.
//

import Foundation
import ComposableArchitecture

class MyRequirementService: HTTPClient, MyRequirementServiceProtocol {
    func getRequirements(by uuid: String) async throws -> [Requirement] {
        var call = MyRequirementCall()
        call.path.append(uuid)

        return try await sendRequest(call: call, responseModel: [Requirement].self)
    }
}

extension MyRequirementService: DependencyKey {
    static let liveValue = MyRequirementService()
}
