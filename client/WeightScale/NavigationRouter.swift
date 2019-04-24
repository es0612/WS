import UIKit

protocol Router {
    var rootViewController: UIViewController? { get }
    func showInputScreen()
    func showListScreen()
    func showMainTabBarScreen()
}

class NavigationRouter: Router {
    var rootViewController: UIViewController?

    func showInputScreen() {
        rootViewController = InputViewController(router: self)
    }

    func showListScreen() {
        let listViewController = ListViewController()

        let listNavController = UINavigationController()
        listNavController.viewControllers = [listViewController]


        rootViewController?.present(listNavController, animated: false, completion: nil)
    }

    func showMainTabBarScreen() {
        let listViewController = ListViewController()

        let listNavController = UINavigationController()
        listNavController.viewControllers = [listViewController]

        listNavController.tabBarItem = UITabBarItem(
            title: "リスト", image: nil, selectedImage: nil
        )

        let tabBarController = UITabBarController(nibName: nil, bundle: nil)

        tabBarController.setViewControllers(
            [listNavController], animated: false
        )

        rootViewController?.present(tabBarController, animated: false, completion: nil)
    }
}
