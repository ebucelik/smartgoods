//
//  MyRequirementCall.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 28.12.22.
//

import Foundation

struct MyRequirementCall: Call {
    var path = ""
    var httpMethod: HTTPMethod = .GET

    init(username: String) {
        self.path = "/projects/\(username)"
    }
}
