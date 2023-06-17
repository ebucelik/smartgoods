//
//  RegisterCall.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 17.06.23.
//

import Foundation

struct RegisterCall: Call {
    var path: String = "/users/register"
    var httpMethod: HTTPMethod = .POST
    var httpBody: Encodable?

    init(register: Register) {
        self.httpBody = register
    }
}
