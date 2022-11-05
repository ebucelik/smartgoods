//
//  TabBarController.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 05.11.22.
//

import SwiftUI
import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tabBar.tintColor = .black

        setupTabBarViews()
    }

    private func setupTabBarViews() {
        // MARK: My Requirement Tab
        let myRequirementViewController = UIHostingController(rootView: MyRequirementView(requirements: MyRequirementView.mockRequirements))

        let myRequirementTabBarItem = UITabBarItem(
            title: "My Requirement",
            image: UIImage(systemName: "house.fill"),
            tag: 0
        )

        myRequirementViewController.tabBarItem = myRequirementTabBarItem


        // MARK: Create Requirement Tab
        let createRequirementViewController = UIHostingController(rootView: CreateRequirementView())

        let createRequirementTabBarItem = UITabBarItem(
            title: "Create Requirement",
            image: UIImage(systemName: "square.and.pencil"),
            tag: 1
        )

        createRequirementViewController.tabBarItem = createRequirementTabBarItem

        // MARK: Account Tab
        let accountViewController = UIHostingController(rootView: AccountView())

        let accountTabBarItem = UITabBarItem(
            title: "Account",
            image: UIImage(systemName: "person.fill"),
            tag: 2
        )

        accountViewController.tabBarItem = accountTabBarItem


        self.viewControllers = [
            myRequirementViewController,
            createRequirementViewController,
            accountViewController
        ]
    }
}

// TODO: Remove each view from this file when the actual view is implemented. Replace the object in the method on the top with the actual view object.

struct CreateRequirementView: View {
    var body: some View {
        VStack {
            Text("Create Requirement")
        }
        .background(.yellow)
    }
}

struct AccountView: View {
    var body: some View {
        VStack {
            Text("Account")
        }
        .background(.red)
    }
}
