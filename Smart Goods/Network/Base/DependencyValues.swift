//
//  DependencyValues.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 28.12.22.
//

import Foundation
import ComposableArchitecture

extension DependencyValues {
    var mainScheduler: DispatchQueue {
        get { self[DispatchQueue.self] }
        set { self[DispatchQueue.self] = newValue }
    }

    var myRequirementService: MyRequirementService {
        get { self[MyRequirementService.self] }
        set { self[MyRequirementService.self] = newValue }
    }
    
    var createRequirementService: CreateRequirementService {
        get { self[CreateRequirementService.self] }
        set { self[CreateRequirementService.self] = newValue }
    }

    var loginService: LoginService {
        get { self[LoginService.self] }
        set { self[LoginService.self] = newValue }
    }

    var registerService: RegisterService {
        get { self[RegisterService.self] }
        set { self[RegisterService.self] = newValue }
    }

    var accountService: AccountService {
        get { self[AccountService.self] }
        set { self[AccountService.self] = newValue }
    }

    var projectService: ProjectService {
        get { self[ProjectService.self] }
        set { self[ProjectService.self] = newValue }
    }
}
