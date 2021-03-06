import Nimble
import Quick

@testable import WeightScale

class NavigationRouterSpec: QuickSpec {
    override func spec() {
        describe("Navigation router（画面遷移）に関するテスト") {
            describe("tab barについて") {
                var tabBarController: UITabBarController!

                beforeEach {
                    let router = NavigationRouter(animated: false)


                    router.showMainTabBarScreen()


                    tabBarController = router.rootViewController as? UITabBarController
                }

                it("List画面を初期表示する"){
                    expect(tabBarController?.displayedTab(isAKindOf: ListViewController.self)).to(beTrue())
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
                    tabBarController.selectTab(withTitle: "記録")


                    expect(tabBarController.displayedTab(isAKindOf: ListViewController.self))
                        .to(beTrue())
                }
            }

            it("Input画面を表示する"){
                let router = NavigationRouter(animated: false)
                router.rootViewController = UIViewController()

                let window = UIWindow(frame: UIScreen.main.bounds)
                window.makeKeyAndVisible()
                window.rootViewController = router.rootViewController


                router.showInputScreen()


                let navController = router.rootViewController?.presentedViewController as? UINavigationController

                expect(navController?.viewControllers.first)
                    .to(beAKindOf(InputViewController.self))
            }

            it("input画面から初期画面に戻る") {
                let router = NavigationRouter(animated: false)
                router.rootViewController = UITabBarController(nibName: nil, bundle: nil)

                let window = UIWindow(frame: UIScreen.main.bounds)
                window.makeKeyAndVisible()
                window.rootViewController = router.rootViewController


                router.showInputScreen()
                router.dismissInputScreen()
                RunLoop.advance()


                let presentedViewController = router.rootViewController?.presentedViewController

                expect(presentedViewController)
                    .to(beNil())
            }
        }
    }
}
