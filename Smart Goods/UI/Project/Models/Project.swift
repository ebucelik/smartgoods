//
//  Project.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 22.06.23.
//

import Foundation

struct Project: Codable, Equatable, Identifiable {
    let id: Int
    let username: String?
    let projectName: String
    let requirements: [String]
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
}
