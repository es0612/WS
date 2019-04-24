import Nimble
import Quick
import Succinct

@testable import WeightScale

class NavigationRouterSpec: QuickSpec {
    override func spec() {
        describe("Navigation router に関するテスト") {

            it("Input画面を初期表示する"){
                let router = NavigationRouter(animated: false)


                router.showInputScreen()


                expect(router.rootViewController).to(beAKindOf(InputViewController.self))
            }

            describe("tab barについてのテスト") {

                var tabBarController: UITabBarController!

                beforeEach {
                    let router = NavigationRouter(animated: false)
                    router.rootViewController = UIViewController()

                    let window = UIWindow(frame: UIScreen.main.bounds)
                    window.makeKeyAndVisible()
                    window.rootViewController = router.rootViewController


                    router.showMainTabBarScreen()


                    tabBarController =
                        router.rootViewController?.presentedViewController
                        as? UITabBarController
                }

                it("リスト画面を初期表示する") {
                    expect(tabBarController.displayedTab(isAKindOf: ListViewController.self)).to(beTrue())
                }

                it("設定画面を表示する") {
                    tabBarController.selectTab(withTitle: "設定")


                    expect(tabBarController.displayedTab(isAKindOf: SettingViewController.self)).to(beTrue())
                }

                it("グラフ画面を表示する") {
                    tabBarController.selectTab(withTitle: "グラフ")


                    expect(tabBarController.displayedTab(isAKindOf: GraphViewController.self)).to(beTrue())
                }

                it("リスト画面を再表示する") {
                    tabBarController.selectTab(withTitle: "グラフ")
                    tabBarController.selectTab(withTitle: "リスト")


                    expect(tabBarController.displayedTab(isAKindOf: ListViewController.self)).to(beTrue())
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



