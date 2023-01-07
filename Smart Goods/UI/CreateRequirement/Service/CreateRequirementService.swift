//
//  CreateRequirementService.swift
//  Smart Goods
//
//  Created by Lisa-Marie Pleyer on 30.12.22.
//

import Foundation
import ComposableArchitecture

class CreateRequirementService: HTTPClient, CreateRequirementServiceProtocol {
    
    func saveRequirement(_ requirement: String, for uuid: String) async throws -> Message {
        var call = SaveRequirementCall(httpBody: requirement)
        call.path.append(uuid)
        
        return try await sendRequest(call: call, responseModel: Message.self)
    }
    
    func checkRequirement(_ requirement: String) async throws -> Bool {
        let call = CheckRequirementCall(httpBody: requirement)
        
        return try await sendRequest(call: call, responseModel: Bool.self)
    }
}

extension CreateRequirementService: DependencyKey {
    static var liveValue: CreateRequirementService = CreateRequirementService()
    static var testValue: CreateRequirementService = CreateRequirementServiceMock()
}
