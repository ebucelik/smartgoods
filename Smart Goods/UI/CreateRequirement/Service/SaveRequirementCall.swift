//
//  SaveRequirementCall.swift
//  Smart Goods
//
//  Created by Lisa-Marie Pleyer on 30.12.22.
//

import Foundation

struct SaveRequirementCall: Call {
    var path: String = "/requirements"
    
    var httpMethod: HTTPMethod = .POST
    
    var httpBody: Encodable?

    init(createRequirement: CreateRequirement) {
        httpBody = createRequirement
    }
}
