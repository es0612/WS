import UIKit

extension UITabBar {
    func applyStyle(_ style: UITabBarStyle) {
        style.apply(to: self)
    }
}

enum UITabBarStyle {
    case main

    func apply(to tabBar: UITabBar) {
        switch self {

        case .main:
            tabBar.barTintColor = UIColor.background.bar

            tabBar.tintColor = UIColor.icon.selected
            tabBar.unselectedItemTintColor = UIColor.icon.normal

        }
    }
}
