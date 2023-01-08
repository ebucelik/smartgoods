//
//  Message.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 07.01.23.
//

import Foundation

struct Message: Codable, Equatable {
    let message: String

    init(message: String) {
        self.message = message
    }
}

#if DEBUG
extension Message {
    static var mockSuccess: Message {
        Message(message: "Success message.")
    }

    static var mockFailure: Message {
        Message(message: "Failure message.")
    }
}
#endif
