import UIKit

protocol Router {
    var rootViewController: UIViewController? { get }
    func showInputScreen()
    func showListScreen()
    func showMainTabBarScreen()
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

    func showInputScreen() {
        rootViewController = InputViewController(
            router: self,
            weightRepository: LocalWeightRepository(
                realmWrapper: LocalRealmWrapper()
            )
        )
    }

    func showListScreen() {
        let listViewController = ListViewController(
            weightRepository: LocalWeightRepository(
                realmWrapper: LocalRealmWrapper()
            )
        )

        let listNavController = UINavigationController()
        listNavController.viewControllers = [listViewController]


        rootViewController?.present(listNavController, animated: animated, completion: nil)
    }

    func showMainTabBarScreen() {
        let listViewController = ListViewController(
            weightRepository: LocalWeightRepository(
                realmWrapper: LocalRealmWrapper()
            )
        )

        let listNavController = UINavigationController()
        listNavController.viewControllers = [listViewController]

        listNavController.tabBarItem = UITabBarItem(
            title: "リスト", image: UIImage(assetIdentifier: .listIcon), selectedImage: nil
        )

        let graphViewController = GraphViewController()

        let graphNavController = UINavigationController()
        graphNavController.viewControllers = [graphViewController]
        graphNavController.tabBarItem = UITabBarItem(
            title: "グラフ", image: UIImage(assetIdentifier: .graphIcon), selectedImage: nil
        )

        let settingViewController = SettingViewController()

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

        rootViewController?.present(tabBarController, animated: animated, completion: nil)
    }
}

extension UIImage {
    enum AssetIdentifier: String {
        case listIcon
        case graphIcon
        case settingIcon
        case inputIcon
    }

    convenience init(assetIdentifier: AssetIdentifier) {
        self.init(named: assetIdentifier.rawValue)!
    }
}
