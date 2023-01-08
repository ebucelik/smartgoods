//
//  Requirement.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 28.12.22.
//

import Foundation

struct Requirement: Codable, Identifiable, Equatable {
    let id: Int
    let requirement: String
    let ruppScheme: Bool
}

extension Requirement {
    static let mockRequirements = [
        Requirement(
            id: 0,
            requirement: "The system shall be able to check requirements",
            ruppScheme: true
        ),
        Requirement(
            id: 1,
            requirement: "The system should be process data quickly",
            ruppScheme: true
        ),
        Requirement(
            id: 2,
            requirement: "The system can do something",
            ruppScheme: false
        )
    ]
    
    static let mockRequirement = Requirement(
        id: 0,
        requirement: "The system shall be able to check requirements",
        ruppScheme: true
    )
}
