//
//  Call.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 08.11.22.
//

import Foundation

public protocol Call {
    var httpScheme: String { get }
    var host: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var parameters: [String: String]? { get }
    var httpBody: Encodable? { get }
}

public extension Call {
    var httpScheme: String { "https://" }

    var host: String { "smartgoods.osc-fr1.scalingo.io" }

    var httpMethod: HTTPMethod { .GET }

    var parameters: [String: String]? { nil }

    var httpBody: Encodable? { nil }

    var httpUrl: String { httpScheme + host + path }
}
