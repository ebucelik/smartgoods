//
//  CreateRequirementServiceMock.swift
//  Smart Goods
//
//  Created by Lisa-Marie Pleyer on 30.12.22.
//

import Foundation

class CreateRequirementServiceMock: CreateRequirementService {
    override func saveRequirement(_ requirement: String, for uuid: String) async throws -> Message {
        return Message.mockSuccess
    }
    
    override func checkRequirement(_ requirement: String) async throws -> Bool {
        return true
    }
}
