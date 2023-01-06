//
//  CreateRequirementService.swift
//  Smart Goods
//
//  Created by Lisa-Marie Pleyer on 30.12.22.
//

import Foundation
import ComposableArchitecture

class CreateRequirementService: HTTPClient, CreateRequirementServiceProtocol {
    
    func saveRequirement(_ requirement: Requirement) async throws -> Requirement {
        let call = SaveRequirementCall(httpBody: requirement)
        
        return try await sendRequest(call: call, responseModel: Requirement.self)
    }
    
    func checkRequirement(_ requirement: Requirement) async throws -> Bool {
        let call = CheckRequirementCall(httpBody: requirement)
        
        return try await sendRequest(call: call, responseModel: Bool.self)
    }
}

extension CreateRequirementService: DependencyKey {
    static var liveValue: CreateRequirementService = CreateRequirementService()
    static var testValue: CreateRequirementService = CreateRequirementServiceMock()
}
