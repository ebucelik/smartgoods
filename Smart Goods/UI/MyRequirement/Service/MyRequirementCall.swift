//
//  MyRequirementCall.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 28.12.22.
//

import Foundation

struct MyRequirementCall: Call {
    var path = "/smartgoods/list/all/"

    var parameters: [String : String]? = nil

    var httpBody: Data? = nil
}
