//
//  CheckRequirementCall.swift
//  Smart Goods
//
//  Created by Lisa-Marie Pleyer on 30.12.22.
//

import Foundation

struct CheckRequirementCall: Call {
    var path: String = "/smartgoods/check"
    
    var httpMethod: HTTPMethod = .POST
    
    var httpBody: Encodable?
}
