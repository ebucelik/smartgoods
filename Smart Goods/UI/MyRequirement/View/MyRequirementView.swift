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
                            Text("Currently no projects created.")
                                .font(.body.monospaced())
                                .foregroundColor(AppColor.primary.color)
                                .padding(.top, 24)
                        }

                        ForEach(viewStore.projects.sorted(by: { $0.id > $1.id }), id: \.self) { project in
                            projectBody(project)
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
        }
    }

    @ViewBuilder
    private func projectBody(_ project: Project) -> some View {
        Section {
            if project.requirements.isEmpty {
                Text("Currently no requirements for this project created.")
                    .font(.caption)
                    .foregroundColor(AppColor.primary.color)
            } else {
                ForEach(project.requirements.sorted(by: { $0.id > $1.id }).prefix(3), id: \.self) { requirement in
                    requirementBody(requirement)
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
    private func requirementBody(_ requirement: Requirement) -> some View {
        HStack {
            Text(requirement.requirement)

            Spacer()

            Image(systemName: "square.and.pencil")

            if !requirement.hint.isEmpty {
                Image(systemName: "info.circle.fill")
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
