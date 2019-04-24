import Nimble
import Quick
import Succinct

@testable import WeightScale

class NavigationRouterSpec: QuickSpec {
    override func spec() {
        describe("Navigation router に関するテスト") {

            it("Input画面を初期表示する"){
                let router = NavigationRouter()


                router.showInputScreen()


                expect(router.rootViewController).to(beAKindOf(InputViewController.self))
            }

            describe("tab barについてのテスト") {
                it("List画面を初期表示する") {
                    let router = NavigationRouter()
                    router.rootViewController = UIViewController()

                    let window = UIWindow(frame: UIScreen.main.bounds)
                    window.makeKeyAndVisible()
                    window.rootViewController = router.rootViewController


                    router.showMainTabBarScreen()

                    
                    let tabBarController = router.rootViewController?.presentedViewController as! UITabBarController
                    expect(tabBarController.displayedTab(isAKindOf: ListViewController.self)).to(beTrue())
                }

                it("設定画面を表示する") {
                    let router = NavigationRouter()
                    router.rootViewController = UIViewController()

                    let window = UIWindow(frame: UIScreen.main.bounds)
                    window.makeKeyAndVisible()
                    window.rootViewController = router.rootViewController


                    router.showMainTabBarScreen()


                    let tabBarController = router.rootViewController?.presentedViewController as! UITabBarController

                    tabBarController.selectTab(withTitle: "設定")
                    expect(tabBarController.displayedTab(isAKindOf: SettingViewController.self)).to(beTrue())
                }
                
            }

        }
    }
}

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



