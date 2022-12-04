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
            NavigationView {
                ScrollView {
                    VStack {
                        Picker("Scheme", selection: $selectedScheme) {
                            ForEach(Scheme.allCases) { scheme in
                                Text(scheme.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                        .padding(.vertical)

                        switch (selectedScheme) {
                        case .none:
                            SubviewNone(requirement: viewStore.binding(\.$customRequirement))
                        case .rupp:
                            SubviewRupp(requirement: viewStore.binding(\.$requirement))
                        }
                    }
                    .padding()
                    .navigationBarTitle("Create Requirement")

                    HStack (alignment: .bottom){
                        Button(action: { viewStore.send(.checkRequirement(selectedScheme)) }) {
                            if viewStore.requirementChecked == .loading {
                                LoadingView()
                            } else {
                                Text("Check")
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .cornerRadius(8)
                        .foregroundColor(.white)

                        Button(action: { viewStore.send(.saveRequirement(selectedScheme)) }) {
                            if viewStore.requirementSaved == .loading {
                                LoadingView()
                            } else {
                                Text("Save")
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .cornerRadius(8)
                        .foregroundColor(.white)
                    }
                    .padding()
                }
            }
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
