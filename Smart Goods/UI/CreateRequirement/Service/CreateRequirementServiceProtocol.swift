//
//  CreateRequirementServiceProtocol.swift
//  Smart Goods
//
//  Created by Lisa-Marie Pleyer on 30.12.22.
//

import Foundation

protocol CreateRequirementServiceProtocol {
    func saveRequirement(_ createRequirement: CreateRequirement) async throws -> CreateRequirementResponse
    func checkRequirement(_ requirement: String) async throws -> RequirementResponse
}
