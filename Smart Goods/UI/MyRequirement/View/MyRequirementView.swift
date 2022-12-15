//
//  MyRequirementView.swift
//  Smart Goods
//
//  Created by Lisa-Marie Pleyer on 05.11.22.
//

import SwiftUI

struct Requirement: Identifiable {
    var id = UUID()
    var text: String
    var status: Bool
}

struct MyRequirementView: View {
    
    let requirements: [Requirement]
    
    var body: some View {
        NavigationView {
            List {
                Section(
                    header: Text("Your Requirements")
                        .font(.body.monospaced().bold())
                        .foregroundColor(AppColor.primary.color)
                        .padding(.top, 24)
                ) {
                    ForEach(requirements) { requirement in
                        requirementBody(requirement)
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .navigationTitle(Text("Smart Goods"))
            .background(AppColor.background.color)
            .scrollContentBackground(.hidden)
        }
    }

    @ViewBuilder
    private func requirementBody(_ requirement: Requirement) -> some View {
        HStack {
            Text(requirement.text)

            Spacer()

            if requirement.status {
                Image(systemName: "checkmark.square.fill").foregroundColor(.green)
            } else {
                Image(systemName: "xmark.square.fill").foregroundColor(.red)
            }
        }
        .padding()
        .listRowInsets(EdgeInsets(top: 8, leading: 1, bottom: 8, trailing: 5))
        .background(AppColor.secondary.color)
        .cornerRadius(15)
        .shadow(radius: 2, x: 5, y: 5)
    }
}

extension MyRequirementView {
    static let mockRequirements = [
        Requirement(text: "The system shall be able to check requirements", status: true),
        Requirement(text: "The system should be process data quickly", status: true),
        Requirement(text: "The system can do something", status: false)
    ]
}

struct MyRequirementView_Previews: PreviewProvider {
    static var previews: some View {
        MyRequirementView(requirements: MyRequirementView.mockRequirements)
    }
}

