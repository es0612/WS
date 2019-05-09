import UIKit

protocol Router {
    var rootViewController: UIViewController? { get }
    func showMainTabBarScreen()
    func showInputScreen()
}

class NavigationRouter: Router {
    // MARK: - Properties
    var rootViewController: UIViewController?

    // MARK: - Injected Dependencies
    private let animated: Bool

    // MARK: - Initialization
    init(animated: Bool) {
        self.animated = animated
    }

    // MARK: - Public Methods
    func showMainTabBarScreen() {
        let listViewController = ListViewController(
            weightRepository: LocalWeightRepository(
                realmWrapper: LocalRealmWrapper()
            ),
            router: self
        )

        let listNavController = UINavigationController()
        listNavController.viewControllers = [listViewController]

        listNavController.tabBarItem = UITabBarItem(
            title: "リスト", image: UIImage(assetIdentifier: .listIcon), selectedImage: nil
        )

        let graphViewController = GraphViewController(
            weightRepository: LocalWeightRepository(
                realmWrapper: LocalRealmWrapper()
            ),
            targetWeightRepository: LocalTargetWeightRepository(
                userDefaultsWrapper: LocalUserDefaultsWrapper()
            )
        )

        let graphNavController = UINavigationController()
        graphNavController.viewControllers = [graphViewController]
        graphNavController.tabBarItem = UITabBarItem(
            title: "グラフ", image: UIImage(assetIdentifier: .graphIcon), selectedImage: nil
        )

        let settingViewController = SettingViewController(
            targetWeightRepository: LocalTargetWeightRepository(
                userDefaultsWrapper: LocalUserDefaultsWrapper()
            )
        )

        let settingNavController = UINavigationController()
        settingNavController.viewControllers = [settingViewController]
        settingNavController.tabBarItem = UITabBarItem(
            title: "設定", image: UIImage(assetIdentifier: .settingIcon), selectedImage: nil
        )


        let tabBarController = UITabBarController(nibName: nil, bundle: nil)

        tabBarController.setViewControllers(
            [listNavController,
             graphNavController,
             settingNavController],
            animated: animated
        )

        rootViewController = tabBarController
    }

    func showInputScreen() {
        let inputViewController = InputViewController(
            router: self,
            weightRepository: LocalWeightRepository(
                realmWrapper: LocalRealmWrapper()
            )
        )

        let inputNavController = UINavigationController()
        inputNavController.viewControllers = [inputViewController]

        rootViewController?.present(inputNavController, animated: animated, completion: nil)
    }
}
