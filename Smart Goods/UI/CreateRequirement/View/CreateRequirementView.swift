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
                                HStack {
                                    switch viewStore.projects {
                                    case let .loaded(projects):
                                        VStack {
                                            HStack {
                                                Text("Select a project:")
                                                    .font(.headline)

                                                Spacer()
                                            }

                                            Picker("",
                                                   selection: viewStore.binding(\.$selectedProject)) {
                                                ForEach(projects, id: \.self) { project in
                                                    Text(project.projectName)
                                                }
                                            }
                                                   .pickerStyle(.menu)
                                                   .tint(AppColor.primary.color)
                                                   .bold()
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)

                                    case .none, .loading:
                                        ProgressView()
                                            .progressViewStyle(.circular)

                                    case .error:
                                        Text("Error occured while loading projects.")
                                    }
                                }
                                .onAppear {
                                    viewStore.send(.getProjects)
                                }

                                SubviewRupp(
                                    requirement: viewStore.binding(\.$requirement),
                                    project: viewStore.binding(\.$selectedProject),
                                    systemName: viewStore.binding(\.$systemName)
                                )
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
                .onDisappear {
                    viewStore.send(.resetState)
                }
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
                Alert(
                    title: alertTitle(viewStore),
                    message: alertMessage(viewStore),
                    dismissButton: .default(
                        Text("Ok")
                    )
                )
            }

            Button(action: {
                hideKeyboard()

                viewStore.send(.saveRequirement(viewStore.selectedScheme))
            }) {
                switch viewStore.requirementSaved {
                case .loading:
                    LoadingView()
                case .loaded:
                    HStack {
                        Text("Save")

                        Image(systemName: "checkmark.circle.fill")
                            .renderingMode(.template)
                            .foregroundColor(AppColor.success.color)
                    }

                case .none:
                    Text("Save")
                case .error:
                    HStack {
                        Text("Error")

                        Image(systemName: "xmark.circle.fill")
                            .renderingMode(.template)
                            .foregroundColor(AppColor.error.color)
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(AppColor.primary.color)
            .cornerRadius(8)
            .foregroundColor(AppColor.secondary.color)
            .font(.body.monospaced().bold())
            .disabled(viewStore.selectedProject.projectName.isEmpty)
            .opacity(viewStore.selectedProject.projectName.isEmpty ? 0.7 : 1)
            .accessibilityElement()
            .accessibilityIdentifier("SaveRequirementButton")
        }
    }

    private func alertTitle(_ viewStore: ViewStoreOf<CreateRequirementCore>) -> Text {
        if case let .loaded(requirementResponse) = viewStore.requirementChecked {
            return requirementResponse.ruppScheme ? Text("Valid requirement") :
            Text("Not a valid requirement")
        }

        return Text("Not a valid requirement")
    }

    private func alertMessage(_ viewStore: ViewStoreOf<CreateRequirementCore>) -> Text {
        if case let .loaded(requirementResponse) = viewStore.requirementChecked {
            if requirementResponse.ruppScheme {
                return requirementResponse.hint.isEmpty ? Text("The requirement conforms to Rupp's scheme.") :
                Text("Hint: \(requirementResponse.hint)")
            } else {
                return requirementResponse.hint.isEmpty ? Text("The requirement does not conform to Rupp's scheme.") :
                Text("Hint: \(requirementResponse.hint)")
            }
        }

        return Text("The requirement does not conform to Rupp's scheme.")
    }
}

#if DEBUG
struct CreateRequirementView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRequirementView(
            store: Store(
                initialState: CreateRequirementCore.State(
                    account: .mock,
                    customRequirement: "",
                    requirement: "",
                    selectedProject: .empty
                ),
                reducer: CreateRequirementCore()
            )
        )
    }
}
#endif
