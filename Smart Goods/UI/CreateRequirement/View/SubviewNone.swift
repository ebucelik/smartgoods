//
//  SubviewNone.swift
//  Smart Goods
//
//  Created by Lisa-Marie Pleyer on 27.11.22.
//

import SwiftUI

struct SubviewNone: View {

    @State public var requirement: String

    var body: some View {
        VStack (alignment: .leading) {
            TextField("Enter requirement ...", text: self.$requirement, axis: .vertical)
                .lineLimit(5, reservesSpace: true)
                .textFieldStyle(.roundedBorder)

            Spacer()

            Text(requirement)
        }
    }
}

struct SubViewNone_Previews: PreviewProvider {
    static var previews: some View {
        SubviewNone(requirement: "")
    }
}
