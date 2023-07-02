//
//  EditRequirementResponse.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 23.06.23.
//

import Foundation

struct EditRequirementResponse: Codable, Equatable {
    let id: Int
    let hint: String
    let requirement: String
    let ruppScheme: Bool
}

extension EditRequirementResponse {
    static var mock: EditRequirementResponse {
        EditRequirementResponse(
            id: 0,
            hint: "Something",
            requirement: "The system shall be able to look good.",
            ruppScheme: false
        )
    }
}
