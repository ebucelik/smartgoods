//
//  UpdateProjectNameCall.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 22.06.23.
//

import Foundation

struct UpdateProjectNameCall: Call {
    var path: String = ""
    var httpMethod: HTTPMethod = .PUT
    var httpBody: Encodable?

    init(username: String,
         updateProjectName: UpdateProjectName) {
        self.path = "/projects/\(username)"
        self.httpBody = updateProjectName
    }
}
