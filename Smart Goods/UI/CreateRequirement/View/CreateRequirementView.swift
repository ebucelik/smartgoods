//
//  CreateRequirementView.swift
//  Smart Goods
//
//  Created by Lisa-Marie Pleyer on 20.11.22.
//
import SwiftUI

struct CreateRequirementView: View {

    enum schemes: String, CaseIterable, Identifiable {
        case rupp = "Rupp's scheme"
        case none = "No scheme"

        var id: Self { self }
    }

    @State private var selectedScheme: schemes = .rupp

    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Picker("Scheme", selection: $selectedScheme) {
                        ForEach(schemes.allCases) { scheme in
                            Text(scheme.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)

                    switch (selectedScheme) {
                    case .none:
                        SubviewNone(requirement: "")
                    case .rupp:
                        SubviewRupp(requirement: "")
                    }
                }
                .padding()
                .navigationBarTitle("Create Requirement")

                HStack (alignment: .bottom){
                    Button("Check") {
                        //TODO
                    }
                    .padding()
                    .background(.blue)
                    .cornerRadius(15)
                    .foregroundColor(.white)

                    Button("Save") {
                        //TODO
                    }
                    .padding()
                    .background(.blue)
                    .cornerRadius(15)
                    .foregroundColor(.white)
                }
                .padding()
            }
        }
    }
}

struct CreateRequirementView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRequirementView()
    }
}
