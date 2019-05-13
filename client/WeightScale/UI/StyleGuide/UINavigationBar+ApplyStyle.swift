import UIKit

extension UINavigationBar {
    func applyStyle(_ style: UINavigationBarStyle) {
        style.apply(to: self)
    }
}

enum UINavigationBarStyle {
    case main

    func apply(to navigationBar: UINavigationBar) {
        switch self {

        case .main:
            navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.text.title
            ]
            navigationBar.barTintColor = UIColor.background.navbar
            navigationBar.isTranslucent = false

        }
    }
}
