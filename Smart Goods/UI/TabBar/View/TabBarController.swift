//
//  TabBarController.swift
//  Smart Goods
//
//  Created by Ing. Ebu Celik, BSc on 05.11.22.
//

import SwiftUI
import UIKit
import ComposableArchitecture
import Combine

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    let store: Store<TabBarCore.State, TabBarCore.Action>
    let viewStore: ViewStore<TabBarCore.State, TabBarCore.Action>
    var cancellables: Set<AnyCancellable> = []

    public init(store: Store<TabBarCore.State, TabBarCore.Action>) {
        self.store = store
        self.viewStore = ViewStore(store)

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tabBar.tintColor = .black

        configureStateObservation()

        checkUuid()

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

    private func configureStateObservation() {
        viewStore.publisher.uuid
            .sink { uuid in
                if let uuid = uuid {
                    print(uuid)
                }
            }
            .store(in: &cancellables)
    }

    private func checkUuid() {
        viewStore.send(.checkUuidAvailability("uuid"))
    }
}

// TODO: Remove each view from this file when the actual view is implemented. Replace the object in the method on the top with the actual view object.

struct AccountView: View {
    var body: some View {
        VStack {
            Text("Account")
        }
        .background(.red)
    }
}
