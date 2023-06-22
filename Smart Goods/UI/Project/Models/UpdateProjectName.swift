//
//  UpdateProjectName.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 22.06.23.
//

import Foundation

public struct UpdateProjectName: Codable, Equatable {
    public var newProjectName: String
    public var oldProjectName: String

    init(newProjectName: String,
         oldProjectName: String) {
        self.newProjectName = newProjectName
        self.oldProjectName = oldProjectName
    }
}

extension UpdateProjectName {
    static var empty: UpdateProjectName {
        UpdateProjectName(
            newProjectName: "",
            oldProjectName: ""
        )
    }
}
