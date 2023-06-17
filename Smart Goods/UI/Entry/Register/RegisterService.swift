//
//  RegisterService.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 17.06.23.
//

import Foundation
import ComposableArchitecture

protocol RegisterServiceProtocol {
    func register(_ register: Register) async throws -> Account
}

class RegisterService: HTTPClient, RegisterServiceProtocol {
    func register(_ register: Register) async throws -> Account {
        let registerCall = RegisterCall(register: register)

        return try await sendRequest(call: registerCall, responseModel: Account.self)
    }
}

extension RegisterService: DependencyKey {
    static let liveValue: RegisterService = RegisterService()
}
