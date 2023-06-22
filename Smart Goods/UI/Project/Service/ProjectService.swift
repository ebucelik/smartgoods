//
//  CreateProjectService.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 22.06.23.
//

import Foundation
import ComposableArchitecture

protocol ProjectServiceProtocol {
    func getProjects(username: String) async throws -> [Project]
    func createProject(_ createProject: CreateProject) async throws -> Project
    func updateProjectName(username: String, _ updateProjectName: UpdateProjectName) async throws -> Project
    func deleteProject(_ id: Int) async throws -> Info
}

class ProjectService: HTTPClient, ProjectServiceProtocol {
    func getProjects(username: String) async throws -> [Project] {
        let getProjectsCall = GetProjectsCall(username: username)

        return try await sendRequest(
            call: getProjectsCall,
            responseModel: [Project].self
        )
    }

    func createProject(_ createProject: CreateProject) async throws -> Project {
        let createProjectCall = CreateProjectCall(createProject: createProject)

        return try await sendRequest(
            call: createProjectCall,
            responseModel: Project.self
        )
    }

    func updateProjectName(username: String, _ updateProjectName: UpdateProjectName) async throws -> Project {
        let updateProjectNameCall = UpdateProjectNameCall(
            username: username,
            updateProjectName: updateProjectName
        )

        return try await sendRequest(
            call: updateProjectNameCall,
            responseModel: Project.self
        )
    }

    func deleteProject(_ id: Int) async throws -> Info {
        let deleteProject = DeleteProjectCall(id: id)

        return try await sendRequest(
            call: deleteProject,
            responseModel: Info.self
        )
    }
}

extension ProjectService: DependencyKey {
    static let liveValue: ProjectService = ProjectService()
}
