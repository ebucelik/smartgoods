//
//  CreateRequirementView.swift
//  Smart Goods
//
//  Created by Lisa-Marie Pleyer on 20.11.22.
//
import SwiftUI
import ComposableArchitecture

struct CreateRequirementView: View {

    enum Scheme: String, CaseIterable, Identifiable {
        case rupp = "Rupp's scheme"
        case none = "No scheme"

        var id: Self { self }
    }

    @State private var selectedScheme: Scheme = .rupp

    let store: StoreOf<CreateRequirementCore>

    public init(store: StoreOf<CreateRequirementCore>) {
        self.store = store
    }

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationStack {
                VStack {
                    ScrollView {
                        VStack {
                            Picker("Scheme", selection: $selectedScheme) {
                                ForEach(Scheme.allCases) { scheme in
                                    Text(scheme.rawValue)
                                }
                            }
                            .pickerStyle(.segmented)
                            .padding(.bottom)

                            switch (selectedScheme) {
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
                    .padding(.horizontal, 20)

                    saveAndCheckButtonBody(viewStore)
                        .padding(.top, 8)
                        .padding(.horizontal, 20)
                }
                .background(AppColor.background.color)
                .navigationTitle(Text("Create Requirement"))
                .padding(.vertical, 24)
            }
        }
    }

    @ViewBuilder
    private func saveAndCheckButtonBody(_ viewStore: ViewStoreOf<CreateRequirementCore>) -> some View {
        HStack(alignment: .bottom) {
            Button(action: { viewStore.send(.checkRequirement(selectedScheme)) }) {
                if viewStore.requirementChecked == .loading {
                    LoadingView()
                } else {
                    Text("CHECK")
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(AppColor.primary.color)
            .cornerRadius(8)
            .foregroundColor(AppColor.secondary.color)
            .font(.body.monospaced().bold())

            Button(action: { viewStore.send(.saveRequirement(selectedScheme)) }) {
                if viewStore.requirementSaved == .loading {
                    LoadingView()
                } else {
                    Text("SAVE")
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
