//
//  DeleteProjectCall.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 22.06.23.
//

import Foundation

struct DeleteProjectCall: Call {
    var path: String = ""
    var httpMethod: HTTPMethod = .DELETE

    init(id: Int) {
        self.path = "/projects/\(id)"
    }
}
