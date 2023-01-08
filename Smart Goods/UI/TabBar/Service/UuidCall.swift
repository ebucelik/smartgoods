//
//  UuidCall.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 28.12.22.
//

import Foundation

struct UuidCall: Call {
    var path = "/user/register/"

    let httpMethod: HTTPMethod = .POST

    let httpBody: Encodable?
}
