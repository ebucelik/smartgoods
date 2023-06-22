//
//  CreateProjectView.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 22.06.23.
//

import SwiftUI
import ComposableArchitecture

struct CreateProjectView: View {

    let store: StoreOf<CreateProjectCore>

    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                VStack {
                    SmartGoodsTextField(
                        imageName: "folder.fill",
                        placeholderText: "Enter a project name...",
                        text: viewStore.binding(\.$createProject.projectName),
                        isSecure: false
                    )

                    SmartGoodsButton(
                        text: "Create Project",
                        isLoading: viewStore.createProjectState.isLoading
                    ) {
                        viewStore.send(.createProject)
                    }

                    Spacer()

                    projectsBody(viewStore)
                }
                .navigationTitle("Create Project")
                .padding()
                .sheet(
                    store: store.scope(
                        state: \.$editProject,
                        action: CreateProjectCore.Action.editProject
                    )
                ) { editProjectStore in
                    EditProjectView(store: editProjectStore)
                }
            }
        }
    }

    @ViewBuilder
    private func projectsBody(_ viewStore: ViewStoreOf<CreateProjectCore>) -> some View {
        VStack {
            switch viewStore.projects {
            case let .loaded(projects):
                List {
                    Section {
                        ForEach(projects) { project in
                            HStack {
                                Text(project.projectName)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                Image(systemName: "square.and.pencil")
                                    .foregroundColor(AppColor.info.color)
                                    .onTapGesture {
                                        viewStore.send(.showEditProjectView(project))
                                    }

                                Image(systemName: "trash.fill")
                                    .foregroundColor(AppColor.error.color)
                                    .onTapGesture {
                                        viewStore.send(.deleteProject(project.id))
                                    }
                            }
                        }
                    } header: {
                        Text("Already created projects")
                    }
                }
                .cornerRadius(8)
                .listStyle(.insetGrouped)

            case .none, .loading:
                ProgressView()
                    .progressViewStyle(.circular)
                    .padding()

                Spacer()

            case .error:
                Text("An error appeared while loading project names.")
            }
        }
        .onAppear {
            viewStore.send(.getProjects)
        }
    }
}

struct CreateProjectView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProjectView(
            store: Store(
                initialState: CreateProjectCore.State(
                    account: .empty
                ),
                reducer: CreateProjectCore()
            )
        )
    }
}
