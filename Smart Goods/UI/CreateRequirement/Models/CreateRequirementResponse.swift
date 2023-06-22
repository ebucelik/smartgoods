//
//  CreateRequirementResponse.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 22.06.23.
//

import Foundation

public struct CreateRequirementResponse: Codable, Hashable, Identifiable {
    public let id: Int
    let username: String
    let projectName: String
    let requirement: String
    let hint: String
    let ruppScheme: Bool

    init(id: Int,
         username: String,
         projectName: String,
         requirement: String,
         hint: String,
         ruppScheme: Bool) {
        self.id = id
        self.username = username
        self.projectName = projectName
        self.requirement = requirement
        self.hint = hint
        self.ruppScheme = ruppScheme
    }
}

extension CreateRequirementResponse {
    static var mock: CreateRequirementResponse {
        CreateRequirementResponse(
            id: 0,
            username: "ebu",
            projectName: "x",
            requirement: "the system will",
            hint: "Nix",
            ruppScheme: false
        )
    }
}
