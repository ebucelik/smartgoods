//
//  CreateRequirementServiceMock.swift
//  Smart Goods
//
//  Created by Lisa-Marie Pleyer on 30.12.22.
//

import Foundation

class CreateRequirementServiceMock: CreateRequirementService {
    override func saveRequirement(call: SaveRequirementCall) async throws -> Requirement {
        return Requirement.mockRequirement
    }
    
    override func checkRequirement(call: CheckRequirementCall) async throws -> Bool {
        return true
    }
}
