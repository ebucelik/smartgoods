//
//  NewPasswordCall.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 18.06.23.
//

import Foundation

struct NewPasswordCall: Call {
    var path: String = ""
    var httpMethod: HTTPMethod = .PUT
    var httpBody: Encodable?

    init(username: String, newPassword: NewPassword) {
        path = "/users/\(username)/password"
        httpBody = newPassword
    }
}
