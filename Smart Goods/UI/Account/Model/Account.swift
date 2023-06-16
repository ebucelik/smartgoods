//
//  Account.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 16.06.23.
//

import Foundation

public struct Account: Codable, Equatable {
    public var firstName: String
    public var lastName: String
    public var username: String
    public var password: String

    public init(firstName: String,
                lastName: String,
                username: String,
                password: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
        self.password = password
    }
}

extension Account {
    static var mock: Account {
        Account(
            firstName: "Ebu",
            lastName: "Bekir",
            username: "ebucelik",
            password: "Celik"
        )
    }

    static var mockNoPassword: Account {
        Account(
            firstName: "Ebu",
            lastName: "Bekir",
            username: "ebucelik",
            password: ""
        )
    }

    static var empty: Account {
        Account(
            firstName: "",
            lastName: "",
            username: "",
            password: ""
        )
    }
}
