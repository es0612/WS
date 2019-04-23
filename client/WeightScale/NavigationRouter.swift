import UIKit

protocol Router {
    var rootViewController: UIViewController? { get }
    func showInputScreen()
    func showListScreen()
}

class NavigationRouter: Router {
    var rootViewController: UIViewController?

    func showInputScreen() {
        rootViewController = InputViewController(router: self)
    }

    func showListScreen() {
        let listViewController = ListViewController()

        rootViewController?.present(listViewController, animated: false, completion: nil)
    }
}
