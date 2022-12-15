//
//  SubviewNone.swift
//  Smart Goods
//
//  Created by Lisa-Marie Pleyer on 27.11.22.
//

import SwiftUI

struct SubviewNone: View {

    @Binding var requirement: String

    var body: some View {
        RoundedVStack {
            TextField("Enter a custom requirement ...", text: self.$requirement, axis: .vertical)
                .lineLimit(5, reservesSpace: true)
                .textFieldStyle(.roundedBorder)
        }
    }
}

struct SubViewNone_Previews: PreviewProvider {
    static var previews: some View {
        SubviewNone(requirement: .constant(""))
    }
}
