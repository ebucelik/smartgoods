//
//  UuidCall.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 28.12.22.
//

import Foundation

struct UuidCall: Call {
    var path = "/user/registration/"

    var parameters: [String : String]? = nil

    var httpBody: Data? = nil

    var httpMethod: HTTPMethod = .POST
}
