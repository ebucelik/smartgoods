//
//  Register.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 07.01.23.
//

import Foundation

struct Register: Codable, Equatable {
    let uuid: String

    init(uuid: String) {
        self.uuid = uuid
    }
}
