import UIKit

extension UITabBarController {
    func displayedTab(isAKindOf compareClass: AnyClass) -> Bool {
        if
            let navController = selectedViewController as? UINavigationController,
            let topViewController = navController.topViewController
        {
            return topViewController.isKind(of: compareClass)
        }

        if let selectedViewController = selectedViewController {
            return selectedViewController.isKind(of: compareClass)
        }

        return false
    }
}
