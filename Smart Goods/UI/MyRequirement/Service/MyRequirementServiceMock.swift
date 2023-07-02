//
//  MyRequirementServiceMock.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 28.12.22.
//

import Foundation

class MyRequirementServiceMock: MyRequirementService {
    override func getProjects(username: String) async throws -> [Project] {
        return [Project.mock]
    }

    override func deleteRequirement(id: Int) async throws -> Info {
        return .mockSuccess
    }

    override func editRequirement(id: Int, editRequirement: EditRequirement) async throws -> EditRequirementResponse {
        return .mock
    }
}
