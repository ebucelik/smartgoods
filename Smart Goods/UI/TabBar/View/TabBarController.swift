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

        viewStore.send(.checkAccount)
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

        tabBar.tintColor = AppColor.primary
        tabBar.isTranslucent = true

        configureStateObservation()

        setupNavigationBar()
    }

    private func configureStateObservation() {
        viewStore.publisher.account
            .sink { [self] account in
                if let account = account {
                    setupTabBarViews(account: account)
                } else {
                    setupEntryView()
                }
            }
            .store(in: &cancellables)
    }

    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = AppColor.primary
        appearance.titleTextAttributes = [.foregroundColor: AppColor.secondary]
        appearance.largeTitleTextAttributes = [.foregroundColor: AppColor.secondary]

        UINavigationBar.appearance().tintColor = AppColor.secondary
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    private func setupEntryView() {
        let entryViewController = UIHostingController(
            rootView: EntryView(
                store: store.scope(
                    state: \.entry,
                    action: TabBarCore.Action.entry
                )
            )
        )

        viewControllers = [
            entryViewController
        ]
    }

    private func setupTabBarViews(account: Account) {
        // MARK: My Requirement Tab
        let myRequirementViewController = UIHostingController(
            rootView: MyRequirementView(
                store: Store(
                    initialState: MyRequirementCore.State(),
                    reducer: MyRequirementCore()
                )
            )
        )

        let myRequirementTabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "house.fill"),
            tag: 0
        )

        myRequirementViewController.tabBarItem = myRequirementTabBarItem

        // MARK: Create Requirement Tab
        let createRequirementViewController = UIHostingController(
            rootView: CreateRequirementView(
                store: Store(
                    initialState: CreateRequirementCore.State(customRequirement: "", requirement: ""),
                    reducer: CreateRequirementCore()
                )
            )
        )

        let createRequirementTabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "square.and.pencil"),
            tag: 1
        )

        createRequirementViewController.tabBarItem = createRequirementTabBarItem

        // MARK: Account Tab
        let accountViewController = UIHostingController(
            rootView: AccountView(
                store: Store(
                    initialState: AccountCore.State(),
                    reducer: AccountCore()
                )
            )
        )

        let accountTabBarItem = UITabBarItem(
            title: nil,
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
