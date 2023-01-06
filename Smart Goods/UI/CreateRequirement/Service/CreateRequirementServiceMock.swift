//
//  CreateRequirementServiceMock.swift
//  Smart Goods
//
//  Created by Lisa-Marie Pleyer on 30.12.22.
//

import Foundation

class CreateRequirementServiceMock: CreateRequirementService {
    override func saveRequirement(_ requirement: Requirement) async throws -> Requirement {
        return Requirement.mockRequirement
    }
    
    override func checkRequirement(_ requirement: Requirement) async throws -> Bool {
        return true
    }
}
