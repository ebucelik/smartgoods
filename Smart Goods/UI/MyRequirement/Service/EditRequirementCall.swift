//
//  EditRequirementCall.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 23.06.23.
//

import Foundation

struct EditRequirementCall: Call {
    var path: String
    var httpMethod: HTTPMethod = .PUT
    var httpBody: Encodable?

    init(id: Int, editRequirement: EditRequirement) {
        self.path = "/requirements/\(id)"
        self.httpBody = editRequirement
    }
}
