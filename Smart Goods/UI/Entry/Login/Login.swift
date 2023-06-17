//
//  Login.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 17.06.23.
//

import Foundation

public struct Login: Codable, Equatable {
    public var username: String
    public var password: String

    init(username: String,
         password: String) {
        self.username = username
        self.password = password
    }
}

extension Login {
    static var empty: Login {
        Login(
            username: "",
            password: ""
        )
    }
}
