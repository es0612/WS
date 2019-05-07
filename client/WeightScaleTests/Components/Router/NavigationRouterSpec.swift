import Nimble
import Quick

@testable import WeightScale

class NavigationRouterSpec: QuickSpec {
    override func spec() {
        describe("Navigation router に関するテスト") {
            it("Input画面を初期表示する"){
                let router = NavigationRouter(animated: false)


                router.showInputScreen()


                let navController = router.rootViewController as! UINavigationController
                expect(navController.viewControllers.first)
                    .to(beAKindOf(InputViewController.self))
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
                    expect(tabBarController.displayedTab(isAKindOf: ListViewController.self))
                        .to(beTrue())
                }

                it("設定画面を表示する") {
                    tabBarController.selectTab(withTitle: "設定")


                    expect(tabBarController.displayedTab(isAKindOf: SettingViewController.self))
                        .to(beTrue())
                }

                it("グラフ画面を表示する") {
                    tabBarController.selectTab(withTitle: "グラフ")


                    expect(tabBarController.displayedTab(isAKindOf: GraphViewController.self))
                        .to(beTrue())
                }

                it("リスト画面を再表示する") {
                    tabBarController.selectTab(withTitle: "グラフ")
                    tabBarController.selectTab(withTitle: "リスト")


                    expect(tabBarController.displayedTab(isAKindOf: ListViewController.self))
                        .to(beTrue())
                }
            }
        }
    }
}
