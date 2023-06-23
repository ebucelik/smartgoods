//
//  EditRequirement.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 23.06.23.
//

import Foundation

public struct EditRequirement: Codable, Equatable {
    public let projectName: String
    public var requirement: String

    init(projectName: String,
         requirement: String) {
        self.projectName = projectName
        self.requirement = requirement
    }
}

extension EditRequirement {
    static var empty: EditRequirement {
        EditRequirement(
            projectName: "",
            requirement: ""
        )
    }
}
