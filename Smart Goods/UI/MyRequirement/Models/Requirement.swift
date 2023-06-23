//
//  Requirement.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 28.12.22.
//

import Foundation

public struct Requirement: Codable, Identifiable, Hashable {
    public let id: Int
    let isRuppScheme: String // TODO: Change back to Bool when backend implemented it.
    let requirement: String
    let hint: String

    init(id: Int, isRuppScheme: String, requirement: String, hint: String) {
        self.id = id
        self.isRuppScheme = isRuppScheme
        self.requirement = requirement
        self.hint = hint
    }
}

extension Requirement {
    static var empty: Requirement {
        Requirement(
            id: 0,
            isRuppScheme: "",
            requirement: "",
            hint: ""
        )
    }
    
    static let mockRequirements = [
        Requirement(
            id: 0,
            isRuppScheme: "true",
            requirement: "The system shall be able to check requirements",
            hint: ""
        ),
        Requirement(
            id: 1,
            isRuppScheme: "true",
            requirement: "The system should be process data quickly",
            hint: ""
        ),
        Requirement(
            id: 2,
            isRuppScheme: "false",
            requirement: "The system can do something",
            hint: ""
        )
    ]
    
    static let mockRequirement = Requirement(
        id: 0,
        isRuppScheme: "true",
        requirement: "The system shall be able to check requirements",
        hint: ""
    )
}
