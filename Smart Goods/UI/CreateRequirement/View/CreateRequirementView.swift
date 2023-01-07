//
//  CreateRequirementView.swift
//  Smart Goods
//
//  Created by Lisa-Marie Pleyer on 20.11.22.
//
import SwiftUI
import ComposableArchitecture

struct CreateRequirementView: View {

    let store: StoreOf<CreateRequirementCore>

    public init(store: StoreOf<CreateRequirementCore>) {
        self.store = store
    }

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationStack {
                VStack {
                    Picker("Scheme", selection: viewStore.binding(\.$selectedScheme)) {
                        ForEach(CreateRequirementCore.Scheme.allCases) { scheme in
                            Text(scheme.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.bottom)

                    ScrollView {
                        VStack {
                            switch (viewStore.selectedScheme) {
                            case .none:
                                SubviewNone(requirement: viewStore.binding(\.$customRequirement))
                            case .rupp:
                                SubviewRupp(requirement: viewStore.binding(\.$requirement))
                            }
                        }
                        .padding()
                    }
                    .background(AppColor.secondary.color)
                    .cornerRadius(8)
                    .onTapGesture {
                        hideKeyboard()
                    }

                    saveAndCheckButtonBody(viewStore)
                        .padding(.top, 8)
                }
                .background(AppColor.background.color)
                .navigationTitle(Text("Create Requirement"))
                .padding(.vertical, 24)
                .padding(.horizontal, 20)
            }
        }
    }

    @ViewBuilder
    private func saveAndCheckButtonBody(_ viewStore: ViewStoreOf<CreateRequirementCore>) -> some View {
        HStack(alignment: .bottom) {
            Button(action: {
                hideKeyboard()

                viewStore.send(.checkRequirement(viewStore.selectedScheme))
            }) {
                switch viewStore.requirementChecked {
                case .loading:
                    LoadingView()
                case .loaded, .none:
                    Text("Check")
                        .onAppear {
                            if case .loaded = viewStore.requirementChecked {
                                viewStore.send(.set(\.$showCheckAlert, true))
                            }
                        }
                case .error:
                    Text("Error")
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(AppColor.primary.color)
            .cornerRadius(8)
            .foregroundColor(AppColor.secondary.color)
            .font(.body.monospaced().bold())
            .alert(isPresented: viewStore.binding(\.$showCheckAlert)) {
                Alert(title: viewStore.requirementChecked == .loaded(true) ?
                      Text("Valid requirement") :
                        Text("Not a valid requirement"))
            }

            Button(action: {
                hideKeyboard()

                viewStore.send(.saveRequirement(viewStore.selectedScheme))
            }) {
                switch viewStore.requirementSaved {
                case .loading:
                    LoadingView()
                case .loaded, .none:
                    Text("Save")
                case .error:
                    Text("Error")
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(AppColor.primary.color)
            .cornerRadius(8)
            .foregroundColor(AppColor.secondary.color)
            .font(.body.monospaced().bold())
        }
    }
}

#if DEBUG
struct CreateRequirementView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRequirementView(
            store: Store(
                initialState: CreateRequirementCore.State(customRequirement: "", requirement: ""),
                reducer: CreateRequirementCore()
            )
        )
    }
}
#endif
