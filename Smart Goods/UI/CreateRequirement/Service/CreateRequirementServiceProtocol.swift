//
//  CreateRequirementServiceProtocol.swift
//  Smart Goods
//
//  Created by Lisa-Marie Pleyer on 30.12.22.
//

import Foundation

protocol CreateRequirementServiceProtocol {
    func saveRequirement(_ requirement: String, for uuid: String) async throws -> Message
    func checkRequirement(_ requirement: String) async throws -> Bool
}
