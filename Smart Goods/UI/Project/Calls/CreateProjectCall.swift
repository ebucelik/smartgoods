//
//  CreateProjectCall.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 22.06.23.
//

import Foundation

struct CreateProjectCall: Call {
    var path: String = "/projects"
    var httpMethod: HTTPMethod = .POST
    var httpBody: Encodable?

    init(createProject: CreateProject) {
        self.httpBody = createProject
    }
}
