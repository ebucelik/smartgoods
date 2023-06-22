//
//  CreateRequirement.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 22.06.23.
//

import Foundation

public struct CreateRequirement: Codable, Hashable {
    let projectName: String
    let requirement: String
    let username: String

    init(projectName: String,
         requirement: String,
         username: String) {
        self.projectName = projectName
        self.requirement = requirement
        self.username = username
    }
}

extension CreateRequirement {
    static var mock: CreateRequirement {
        CreateRequirement(
            projectName: "Test",
            requirement: "test requirement",
            username: "ebu"
        )
    }
}
