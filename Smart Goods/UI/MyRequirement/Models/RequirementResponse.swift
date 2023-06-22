//
//  RequirementResponse.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 18.06.23.
//

import Foundation

public struct RequirementResponse: Codable, Equatable {
    let hint: String
    let ruppScheme: Bool

    public init(hint: String, ruppScheme: Bool) {
        self.hint = hint
        self.ruppScheme = ruppScheme
    }
}

extension RequirementResponse {
    static var empty: RequirementResponse {
        RequirementResponse(
            hint: "",
            ruppScheme: false
        )
    }
}
