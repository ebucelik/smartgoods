//
//  DependencyValues.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 28.12.22.
//

import Foundation
import ComposableArchitecture

extension DependencyValues {
    var tabBarService: TabBarService {
        get { self[TabBarService.self] }
        set { self[TabBarService.self] = newValue }
    }

    var mainScheduler: DispatchQueue {
        get { self[DispatchQueue.self] }
        set { self[DispatchQueue.self] = newValue }
    }
}
