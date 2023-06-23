//
//  Project.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 22.06.23.
//

import Foundation

struct Project: Codable, Hashable, Identifiable {
    let id: Int
    let username: String?
    let projectName: String
    let requirements: [Requirement]
}

extension Project {
    static var empty: Project {
        Project(
            id: 0,
            username: nil,
            projectName: "",
            requirements: []
        )
    }

    static var mock: Project {
        Project(
            id: 0,
            username: "ebu",
            projectName: "the system",
            requirements: Requirement.mockRequirements
        )
    }
}
