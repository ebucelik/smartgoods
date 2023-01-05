//
//  CreateRequirementService.swift
//  Smart Goods
//
//  Created by Lisa-Marie Pleyer on 30.12.22.
//

import Foundation
import ComposableArchitecture

class CreateRequirementService: HTTPClient, CreateRequirementServiceProtocol {
    
    func saveRequirement(call: SaveRequirementCall) async throws -> Requirement {
        try await sendRequest(call: call, responseModel: Requirement.self)
    }
    
    func checkRequirement(call: CheckRequirementCall) async throws -> Bool {
        try await sendRequest(call: call, responseModel: Bool.self)
    }
}

extension CreateRequirementService: DependencyKey {
    static var liveValue: CreateRequirementService = CreateRequirementService()
    static var testValue: CreateRequirementService = CreateRequirementServiceMock()
}
