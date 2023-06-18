//
//  Info.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 07.01.23.
//

import Foundation

struct Info: Codable, Equatable {
    let info: String

    init(info: String) {
        self.info = info
    }
}

extension Info {
    static var mockSuccess: Info {
        Info(info: "Success info.")
    }

    static var mockFailure: Info {
        Info(info: "Failure info.")
    }
}
