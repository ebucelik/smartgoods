//
//  TabBarController.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 05.11.22.
//

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
        let myRequirementViewController = UIViewController()
        myRequirementViewController.view.backgroundColor = .white

        let myRequirementTabBarItem = UITabBarItem(
            title: "My Requirement",
            image: UIImage(systemName: "house.fill"),
            tag: 0
        )

        myRequirementViewController.tabBarItem = myRequirementTabBarItem


        // MARK: Create Requirement Tab
        let createRequirementViewController = UIViewController()
        createRequirementViewController.view.backgroundColor = .white

        let createRequirementTabBarItem = UITabBarItem(
            title: "Create Requirement",
            image: UIImage(systemName: "square.and.pencil"),
            tag: 1
        )

        createRequirementViewController.tabBarItem = createRequirementTabBarItem

        // MARK: Account Tab
        let accountViewController = UIViewController()
        accountViewController.view.backgroundColor = .white

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
