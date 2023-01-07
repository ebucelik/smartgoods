//
//  View+Extensions.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 07.01.23.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
#endif
