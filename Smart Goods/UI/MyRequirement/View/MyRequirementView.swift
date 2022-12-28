//
//  MyRequirementView.swift
//  Smart Goods
//
//  Created by Lisa-Marie Pleyer on 05.11.22.
//

import SwiftUI
import ComposableArchitecture

struct MyRequirementView: View {
    
    let store: StoreOf<MyRequirementCore>

    init(store: StoreOf<MyRequirementCore>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                switch viewStore.requirementsState {
                case let .loaded(requirements):
                    List {
                        Section(
                            header: Text("Your Requirements")
                                .font(.body.monospaced().bold())
                                .foregroundColor(AppColor.primary.color)
                                .padding(.top, 24)
                        ) {
                            if requirements.isEmpty {
                                Text("Currently no requirements created.")
                                    .font(.body.monospaced())
                                    .foregroundColor(AppColor.primary.color)
                                    .padding(.top, 24)
                            }

                            ForEach(requirements) { requirement in
                                requirementBody(requirement)
                            }
                            .listRowSeparator(.hidden)
                        }
                    }
                    .navigationTitle(Text("Smart Goods"))
                    .background(AppColor.background.color)
                    .scrollContentBackground(.hidden)

                case .loading, .none:
                    LoadingView(tint: .black)

                case let .error(error):
                    ErrorView(error: error.localizedDescription)
                }
            }
            .onAppear {
                viewStore.send(.fetchRequirements)
            }
        }
    }

    @ViewBuilder
    private func requirementBody(_ requirement: Requirement) -> some View {
        HStack {
            Text(requirement.requirement)

            Spacer()

            // TODO: Check status from backend. Talk to backend.
//            if requirement.status {
//                Image(systemName: "checkmark.square.fill").foregroundColor(.green)
//            } else {
//                Image(systemName: "xmark.square.fill").foregroundColor(.red)
//            }
        }
        .padding()
        .listRowInsets(EdgeInsets(top: 8, leading: 1, bottom: 8, trailing: 5))
        .background(AppColor.secondary.color)
        .cornerRadius(15)
    }
}

struct MyRequirementView_Previews: PreviewProvider {
    static var previews: some View {
        MyRequirementView(
            store: Store(
                initialState: MyRequirementCore.State(),
                reducer: MyRequirementCore()
            )
        )
    }
}

