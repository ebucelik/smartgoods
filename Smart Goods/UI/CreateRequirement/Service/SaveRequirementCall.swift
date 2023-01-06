//
//  SaveRequirementCall.swift
//  Smart Goods
//
//  Created by Lisa-Marie Pleyer on 30.12.22.
//

import Foundation

struct SaveRequirementCall: Call {
    var path: String = "/smartgoods/save"
    
    var httpMethod: HTTPMethod = .POST
    
    var httpBody: Encodable?
}
