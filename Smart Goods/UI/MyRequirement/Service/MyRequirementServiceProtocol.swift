//
//  MyRequirementServiceProtocol.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 28.12.22.
//

import Foundation

protocol MyRequirementServiceProtocol {
    func getProjects(username: String) async throws -> [Project]
    func deleteRequirement(id: Int) async throws -> Info
    func editRequirement(id: Int, editRequirement: EditRequirement) async throws -> EditRequirementResponse
}
