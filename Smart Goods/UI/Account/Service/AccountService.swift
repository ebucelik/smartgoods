//
//  AccountService.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 18.06.23.
//

import Foundation
import ComposableArchitecture

protocol AccountServiceProtocol {
    func changePassword(username: String, newPassword: NewPassword) async throws -> Info
}

class AccountService: HTTPClient, AccountServiceProtocol {
    func changePassword(username: String, newPassword: NewPassword) async throws -> Info {
        let newPasswordCall = NewPasswordCall(username: username, newPassword: newPassword)

        return try await sendRequest(call: newPasswordCall, responseModel: Info.self)
    }
}

extension AccountService: DependencyKey {
    static let liveValue: AccountService = AccountService()
}
