//
//  EditRequirementView.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 23.06.23.
//

import SwiftUI
import ComposableArchitecture

struct EditRequirementView: View {
    let store: StoreOf<EditRequirementCore>

    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                VStack {
                    SmartGoodsTextField(
                        imageName: "pencil",
                        placeholderText: "",
                        text: viewStore.binding(\.$editRequirement.requirement),
                        isSecure: false
                    )

                    Spacer()

                    SmartGoodsButton(
                        text: "Update requirement",
                        isLoading: viewStore.editRequirementState.isLoading
                    ) {
                        viewStore.send(.editRequirement)
                    }
                }
                .navigationTitle(viewStore.editRequirement.projectName)
                .padding()
            }
        }
    }
}

struct EditRequirementView_Previews: PreviewProvider {
    static var previews: some View {
        EditRequirementView(
            store: Store(
                initialState: EditRequirementCore.State(
                    id: 0,
                    editRequirement: .empty
                ),
                reducer: EditRequirementCore()
            )
        )
    }
}
