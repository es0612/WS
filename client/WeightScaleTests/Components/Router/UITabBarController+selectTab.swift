import UIKit

extension UITabBarController {
    func selectTab(withTitle searchTitle: String) {
        if let tabBarItems = tabBar.items {
            for index in 0..<tabBarItems.count {
                let tabBarItem = tabBarItems[index]

                if tabBarItem.title == searchTitle {
                    selectedIndex = index
                    continue
                }
            }
        }
    }
}
