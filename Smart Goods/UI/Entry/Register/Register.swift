//
//  Register.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 17.06.23.
//

import Foundation

public struct Register: Codable, Equatable {
    public var firstName: String
    public var lastName: String
    public var password: String
    public var username: String

    init(firstName: String,
         lastName: String,
         password: String,
         username: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.password = password
        self.username = username
    }
}

extension Register {
    static var empty: Register {
        Register(
            firstName: "",
            lastName: "",
            password: "",
            username: ""
        )
    }
}
