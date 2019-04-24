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

    init(animated: Bool) {
        self.animated = animated
    }

    func showInputScreen() {
        rootViewController = InputViewController(router: self)
    }

    func showListScreen() {
        let listViewController = ListViewController()

        let listNavController = UINavigationController()
        listNavController.viewControllers = [listViewController]


        rootViewController?.present(listNavController, animated: animated, completion: nil)
    }

    func showMainTabBarScreen() {
        let listViewController = ListViewController()

        let listNavController = UINavigationController()
        listNavController.viewControllers = [listViewController]

        listNavController.tabBarItem = UITabBarItem(
            title: "リスト", image: nil, selectedImage: nil
        )


        let settingViewController = SettingViewController()

        let settingNavController = UINavigationController()
        settingNavController.viewControllers = [settingViewController]
        settingNavController.tabBarItem = UITabBarItem(
            title: "設定", image: nil, selectedImage: nil
        )


        let tabBarController = UITabBarController(nibName: nil, bundle: nil)

        tabBarController.setViewControllers(
            [listNavController, settingNavController], animated: animated
        )

        rootViewController?.present(tabBarController, animated: animated, completion: nil)
    }
}
