//
//  CreateRequirementServiceProtocol.swift
//  Smart Goods
//
//  Created by Lisa-Marie Pleyer on 30.12.22.
//

import Foundation

protocol CreateRequirementServiceProtocol {
    func saveRequirement(call: SaveRequirementCall) async throws -> Requirement
    func checkRequirement(call: CheckRequirementCall) async throws -> Bool
}
