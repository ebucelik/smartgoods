//
//  CreateProject.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 22.06.23.
//

import Foundation

public struct CreateProject: Codable, Equatable {
    var projectName: String
    var username: String

    init(projectName: String,
         username: String) {
        self.projectName = projectName
        self.username = username
    }
}

extension CreateProject {
    static var empty: CreateProject {
        CreateProject(
            projectName: "",
            username: ""
        )
    }
}
