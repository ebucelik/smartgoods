//
//  Loadable.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 03.12.22.
//

import Foundation

public enum Loadable<Item> where Item: Codable, Item: Equatable {
    case loading
    case loaded(Item)
    case error(HTTPError)
    case none
}

extension Loadable: Equatable {
    public static func == (lhs: Loadable<Item>, rhs: Loadable<Item>) -> Bool {
        switch(lhs, rhs) {
        case (.none, .none):
            return true
        case (.loading, .loading):
            return true
        case (let .loaded(itemLhs), let .loaded(itemRhs)):
            return itemLhs == itemRhs
        case (let .error(errorLhs), let .error(errorRhs)):
            return errorLhs == errorRhs
        default:
            return false
        }
    }
}
