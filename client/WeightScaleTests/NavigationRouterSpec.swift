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

            it("List画面を表示する") {
                let router = NavigationRouter()
                router.rootViewController = UIViewController()

                let window = UIWindow(frame: UIScreen.main.bounds)
                window.makeKeyAndVisible()
                window.rootViewController = router.rootViewController


                router.showListScreen()


                expect(router.rootViewController?.presentedViewController).to(beAKindOf(ListViewController.self))
            }
        }
    }
}
