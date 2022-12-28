//
//  TabBarServiceMock.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 28.12.22.
//

import Foundation

class TabBarServiceMock: TabBarService {
    override func setUuid(with uuid: String) async throws {
        print("Uuid was sent to the backend.")
    }
}
