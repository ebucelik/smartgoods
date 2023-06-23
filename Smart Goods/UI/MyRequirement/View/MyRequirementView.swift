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
                    switch viewStore.projectsState {
                    case .loaded, .loading, .none:
                        if viewStore.projects.isEmpty {
                            Text("Currently no projects available.")
                                .font(.body.monospaced())
                                .foregroundColor(AppColor.primary.color)
                                .padding(.top, 24)
                        }

                        ForEach(viewStore.projects.sorted(by: { $0.id > $1.id }), id: \.self) { project in
                            projectBody(project, viewStore)
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(EmptyView())

                    case let .error(error):
                        ErrorView(
                            error: error.localizedDescription,
                            action: { viewStore.send(.fetchProjects) }
                        )
                    }
                }
                .frame(maxHeight: .infinity)
                .navigationTitle(Text("Smart Goods"))
                .background(.clear)
                .scrollContentBackground(.hidden)
                .refreshable {
                    viewStore.send(.fetchProjects)
                }
                .overlay {
                    if viewStore.projectsState.isLoading {
                        LoadingView(
                            tint: AppColor.primary.color,
                            fullScreen: true
                        )
                    }
                }
            }
            .onAppear {
                viewStore.send(.fetchProjects)
            }
            .sheet(
                store: store.scope(
                    state: \.$editRequirement,
                    action: MyRequirementCore.Action.editRequirement
                )
            ) { editRequirementStore in
                EditRequirementView(store: editRequirementStore)
            }
            .alert(isPresented: viewStore.binding(\.$showHintAlert)) {
                Alert(
                    title: alertTitle(viewStore.requirement),
                    message: alertMessage(viewStore.requirement),
                    dismissButton: .default(
                        Text("Ok")
                    )
                )
            }
        }
    }

    @ViewBuilder
    private func projectBody(_ project: Project, _ viewStore: ViewStoreOf<MyRequirementCore>) -> some View {
        Section {
            if project.requirements.isEmpty {
                Text("Currently no requirements for this project available.")
                    .font(.caption)
                    .foregroundColor(AppColor.primary.color)
            } else {
                ForEach(project.requirements.sorted(by: { $0.id > $1.id }).prefix(3), id: \.self) { requirement in
                    requirementBody(
                        requirement,
                        project,
                        viewStore
                    )
                }
            }
        } header: {
            HStack {
                Text(project.projectName)
                    .font(.body.monospaced().bold())
                    .foregroundColor(AppColor.primary.color)

                Spacer()

                if !project.requirements.isEmpty {
                    Image(systemName: "arrow.right.circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            }
        }
    }

    @ViewBuilder
    private func requirementBody(_ requirement: Requirement,
                                 _ project: Project,
                                 _ viewStore: ViewStoreOf<MyRequirementCore>) -> some View {
        HStack {
            Text(requirement.requirement)

            Spacer()

            Image(systemName: "square.and.pencil")
                .onTapGesture {
                    viewStore.send(.showEditRequirementView(project.projectName, requirement))
                }

            if !requirement.hint.isEmpty {
                Image(systemName: "info.circle")
                    .onTapGesture {
                        viewStore.send(.showHint(requirement))
                    }
            }

            Image(systemName: "trash.fill")
                .foregroundColor(AppColor.error.color)
                .onTapGesture {
                    viewStore.send(.deleteRequirement(requirement.id))
                }

//            if requirement.isRuppScheme == "true" {
//                Text("OK")
//                    .foregroundColor(AppColor.success.color)
//                    .bold()
//            } else {
//                Text("NOT OK")
//                    .foregroundColor(AppColor.error.color)
//                    .bold()
//            }
        }
        .padding()
        .listRowInsets(EdgeInsets(top: 8, leading: 1, bottom: 8, trailing: 5))
        .background(AppColor.secondary.color)
        .cornerRadius(15)
    }

    private func alertTitle(_ requirement: Requirement) -> Text {
        return requirement.isRuppScheme == "true" ? Text("Valid requirement") :
        Text("Not a valid requirement")
    }

    private func alertMessage(_ requirement: Requirement) -> Text {
        if requirement.isRuppScheme == "true" {
            return requirement.hint.isEmpty ? Text("The requirement conforms to Rupp's scheme.") :
            Text("Hint: \(requirement.hint)")
        } else {
            return requirement.hint.isEmpty ? Text("The requirement does not conform to Rupp's scheme.") :
            Text("Hint: \(requirement.hint)")
        }
    }
}

#if DEBUG
struct MyRequirementView_Previews: PreviewProvider {
    static var previews: some View {
        MyRequirementView(
            store: Store(
                initialState: MyRequirementCore.State(account: .mock),
                reducer: MyRequirementCore()
            )
        )
    }
}
#endif
