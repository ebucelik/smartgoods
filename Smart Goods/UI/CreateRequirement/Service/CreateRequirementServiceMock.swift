//
//  CreateRequirementServiceMock.swift
//  Smart Goods
//
//  Created by Lisa-Marie Pleyer on 30.12.22.
//

import Foundation

class CreateRequirementServiceMock: CreateRequirementService {
    override func saveRequirement(_ createRequirement: CreateRequirement) async throws -> CreateRequirementResponse {
        return .mock
    }
    
    override func checkRequirement(_ requirement: String) async throws -> RequirementResponse {
        return .empty
    }
}
