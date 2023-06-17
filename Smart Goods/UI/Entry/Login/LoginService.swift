//
//  LoginService.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 17.06.23.
//

import Foundation
import ComposableArchitecture

protocol LoginServiceProtocol {
    func login(_ login: Login) async throws -> Account
}

class LoginService: HTTPClient, LoginServiceProtocol {
    func login(_ login: Login) async throws -> Account {
        let loginCall = LoginCall(login: login)

        return try await sendRequest(call: loginCall, responseModel: Account.self)
    }
}

extension LoginService: DependencyKey {
    static let liveValue: LoginService = LoginService()
}
