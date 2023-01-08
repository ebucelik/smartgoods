//
//  DispatchQueue+Extensions.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 28.12.22.
//

import Foundation
import ComposableArchitecture

extension DispatchQueue: DependencyKey {
    public static let liveValue: DispatchQueue = .main
    public static let testValue: DispatchQueue = .main
}
