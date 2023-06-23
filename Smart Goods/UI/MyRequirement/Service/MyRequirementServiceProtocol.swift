//
//  MyRequirementServiceProtocol.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 28.12.22.
//

import Foundation

protocol MyRequirementServiceProtocol {
    func getProjects(username: String) async throws -> [Project]
}
