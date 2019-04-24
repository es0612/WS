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
                    expect(tabBarController.selectedViewController).to(beAKindOf(UINavigationController.self))
                }
                
            }

        }
    }
}
