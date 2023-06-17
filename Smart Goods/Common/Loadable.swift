//
//  Loadable.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 03.12.22.
//

import Foundation

public enum Loadable<Item>: Equatable where Item: Codable, Item: Equatable {
    case loading
    case loaded(Item)
    case error(HTTPError)
    case none

    var isLoading: Bool {
        switch self {
        case .loading:
            return true
        default:
            return false
        }
    }
}
