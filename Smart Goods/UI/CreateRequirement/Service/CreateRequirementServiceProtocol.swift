//
//  CreateRequirementServiceProtocol.swift
//  Smart Goods
//
//  Created by Lisa-Marie Pleyer on 30.12.22.
//

import Foundation

protocol CreateRequirementServiceProtocol {
    func saveRequirement(_ requirement: Requirement) async throws -> Requirement
    func checkRequirement(_ requirement: Requirement) async throws -> Bool
}
