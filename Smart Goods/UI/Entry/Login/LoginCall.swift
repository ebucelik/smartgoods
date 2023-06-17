//
//  LoginCall.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 17.06.23.
//

import Foundation

struct LoginCall: Call {
    var path: String = "/users/login"
    var httpMethod: HTTPMethod = .POST
    var httpBody: Encodable?

    init(login: Login) {
        self.httpBody = login
    }
}
