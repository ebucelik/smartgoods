//
//  MyRequirementServiceMock.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 28.12.22.
//

import Foundation

class MyRequirementServiceMock: MyRequirementService {
    override func getRequirements(by uuid: String) async throws -> [Requirement] {
        return Requirement.mockRequirements
    }
}
