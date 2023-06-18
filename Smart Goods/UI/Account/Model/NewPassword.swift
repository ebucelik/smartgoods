//
//  NewPassword.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 18.06.23.
//

import Foundation

public struct NewPassword: Codable, Equatable {
    public var controlNewPassword: String
    public var newPassword: String
    public var oldPassword: String

    init(controlNewPassword: String,
         newPassword: String,
         oldPassword: String) {
        self.controlNewPassword = controlNewPassword
        self.newPassword = newPassword
        self.oldPassword = oldPassword
    }
}

extension NewPassword {
    static var empty: NewPassword {
        NewPassword(
            controlNewPassword: "",
            newPassword: "",
            oldPassword: ""
        )
    }
}
