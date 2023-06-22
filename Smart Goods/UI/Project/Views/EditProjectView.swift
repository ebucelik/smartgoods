//
//  EditProjectView.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 22.06.23.
//

import SwiftUI
import ComposableArchitecture

struct EditProjectView: View {
    let store: StoreOf<EditProjectCore>

    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                VStack {
                    SmartGoodsTextField(
                        imageName: "folder.fill",
                        placeholderText: "Enter a new project name...",
                        text: viewStore.binding(\.$editProject.newProjectName),
                        isSecure: false
                    )

                    Spacer()

                    SmartGoodsButton(
                        text: "Update project name",
                        isLoading: viewStore.editProjectState.isLoading
                    ) {
                        viewStore.send(.editProject)
                    }
                }
                .navigationTitle(viewStore.editProject.oldProjectName)
                .padding()
            }
        }
    }
}

struct EditProjectView_Previews: PreviewProvider {
    static var previews: some View {
        EditProjectView(
            store: Store(
                initialState: EditProjectCore.State(
                    editProject: .empty,
                    account: .empty
                ), reducer: EditProjectCore()
            )
        )
    }
}
