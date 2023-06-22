//
//  CreateRequirementService.swift
//  Smart Goods
//
//  Created by Lisa-Marie Pleyer on 30.12.22.
//

import Foundation
import ComposableArchitecture

class CreateRequirementService: HTTPClient, CreateRequirementServiceProtocol {
    
    func saveRequirement(_ createRequirement: CreateRequirement) async throws -> CreateRequirementResponse {
        let call = SaveRequirementCall(createRequirement: createRequirement)
        
        return try await sendRequest(call: call, responseModel: CreateRequirementResponse.self)
    }
    
    func checkRequirement(_ requirement: String) async throws -> RequirementResponse {
        let call = CheckRequirementCall(httpBody: requirement)
        
        return try await sendRequest(call: call, responseModel: RequirementResponse.self)
    }
}

extension CreateRequirementService: DependencyKey {
    static var liveValue: CreateRequirementService = CreateRequirementService()
    static var testValue: CreateRequirementService = CreateRequirementServiceMock()
}
