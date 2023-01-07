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
                List {
                    switch viewStore.requirementsState {
                    case .loaded, .loading, .none:
                        Section(
                            header: Text("Your Requirements")
                                .font(.body.monospaced().bold())
                                .foregroundColor(AppColor.primary.color)
                                .padding(.top, 24)
                        ) {
                            if viewStore.requirements.isEmpty {
                                Text("Currently no requirements created.")
                                    .font(.body.monospaced())
                                    .foregroundColor(AppColor.primary.color)
                                    .padding(.top, 24)
                            }

                            ForEach(viewStore.requirements) { requirement in
                                requirementBody(requirement)
                            }
                            .listRowSeparator(.hidden)
                            .listRowBackground(EmptyView())
                        }

                    case let .error(error):
                        ErrorView(
                            error: error.localizedDescription,
                            action: { viewStore.send(.fetchRequirements) }
                        )
                    }
                }
                .frame(maxHeight: .infinity)
                .navigationTitle(Text("Smart Goods"))
                .background(.clear)
                .scrollContentBackground(.hidden)
                .refreshable {
                    viewStore.send(.fetchRequirements)
                }
                .overlay {
                    if viewStore.requirementsState.isLoading {
                        LoadingView(
                            tint: AppColor.primary.color,
                            fullScreen: true
                        )
                    }
                }
            }
            .onAppear {
                if case .none = viewStore.requirementsState {
                    viewStore.send(.fetchRequirements)
                }
            }
        }
    }

    @ViewBuilder
    private func requirementBody(_ requirement: Requirement) -> some View {
        HStack {
            Text(requirement.requirement)

            Spacer()

            if requirement.ruppScheme {
                Text("OK")
                    .foregroundColor(AppColor.success.color)
                    .bold()
            }
        }
        .padding()
        .listRowInsets(EdgeInsets(top: 8, leading: 1, bottom: 8, trailing: 5))
        .background(AppColor.secondary.color)
        .cornerRadius(15)
    }
}

#if DEBUG
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
#endif
