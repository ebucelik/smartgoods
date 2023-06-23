//
//  DeleteRequirementCall.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 23.06.23.
//

import Foundation

struct DeleteRequirementCall: Call {
    var path: String = ""
    var httpMethod: HTTPMethod = .DELETE

    init(id: Int) {
        self.path = "/requirements/\(id)"
    }
}
