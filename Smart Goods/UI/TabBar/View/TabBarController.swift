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

    // MARK: Views
    let loadingView: UIView = {
        let loadingView = UIHostingController(rootView: LoadingView(tint: .black))
        loadingView.view.translatesAutoresizingMaskIntoConstraints = false
        loadingView.view.backgroundColor = AppColor.background
        loadingView.view.isHidden = true
        return loadingView.view
    }()

    let errorView: UIView = {
        let errorView = UIHostingController(rootView: ErrorView())
        errorView.view.translatesAutoresizingMaskIntoConstraints = false
        errorView.view.backgroundColor = AppColor.background
        errorView.view.isHidden = false
        return errorView.view
    }()

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

        configureView()

        setupConstraints()
    }

    private func configureView() {
        view.addSubview(loadingView)
        view.addSubview(errorView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.topAnchor.constraint(equalTo: view.topAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tabBar.tintColor = AppColor.primary
        tabBar.isTranslucent = true

        configureStateObservation()

        checkUuid()

        setupNavigationBar()

        setupTabBarViews()
    }

    private func configureStateObservation() {
        viewStore.publisher.uuidState
            .sink { [self] uuidState in
                switch uuidState {
                case .loaded:
                    loadingView.isHidden = true
                    errorView.isHidden = true

                case .loading, .none:
                    loadingView.isHidden = false
                    errorView.isHidden = true

                case let .error(error):
                    loadingView.isHidden = true
                    errorView.isHidden = false // TODO: Show the incoming error in the view.

                    print(error)
                }
            }
            .store(in: &cancellables)
    }

    private func checkUuid() {
        viewStore.send(.checkUuidAvailability("uuid"))
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

    private func setupTabBarViews() {
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
        let accountViewController = UIHostingController(rootView: AccountView())

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

// TODO: Remove each view from this file when the actual view is implemented. Replace the object in the method on the top with the actual view object.

struct AccountView: View {
    var body: some View {
        VStack {
            Text("Account")
        }
        .background(.red)
    }
}
