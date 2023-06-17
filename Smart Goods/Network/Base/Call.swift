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
    var httpScheme: String { "http://" }

    var host: String { "localhost:8080/api/v2" }

    var httpMethod: HTTPMethod { .GET }

    var parameters: [String: String]? { nil }

    var httpBody: Encodable? { nil }

    var httpUrl: String { httpScheme + host + path }
}
