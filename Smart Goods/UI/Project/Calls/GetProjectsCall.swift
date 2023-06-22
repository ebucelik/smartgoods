//
//  GetProjectsCall.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 22.06.23.
//

import Foundation

struct GetProjectsCall: Call {
    var path: String = ""
    var httpMethod: HTTPMethod = .GET

    init(username: String) {
        self.path = "/projects/\(username)"
    }
}
