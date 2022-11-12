//
//  HTTPError.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 08.11.22.
//

import Foundation

public enum HTTPError: Error {
    case error(String)
    case unauthorized
    case notFound
    case unknown
    case invalidURL
    case decode
    case noResponse
    case notModified
    case serverError
    case unexpectedStatusCode

    var message: String {
        switch self {
        case .decode:
            return "Decoding error."

        case .unauthorized:
            return "Session expired."

        case .invalidURL:
            return "URL was invalid."

        case .notModified:
            return "The content was not modified."

        case .serverError:
            return "A server error occurred."

        default:
            return "Unknown error."
        }
    }
}
