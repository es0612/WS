import UIKit

protocol Router {
    var rootViewController: UIViewController? { get }
    func setup()
    func showListScreen()
}

class NavigationRouter: Router {
    var rootViewController: UIViewController?

    func setup() {
        rootViewController = InputViewController(router: self)
    }

    func showListScreen() {
        let listViewController = ListViewController()

        rootViewController?.present(listViewController, animated: false, completion: nil)
    }
}
