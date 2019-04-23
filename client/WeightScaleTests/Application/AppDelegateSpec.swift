import Nimble
import Quick
import Succinct

@testable import WeightScale

class AppDelegateSpec: QuickSpec {
    override func spec() {
        describe("App Delegate に関するテスト") {
            it("アプリ起動時にInput画面を初期表示する") {
                let spyRouter = SpyRouter()
                let appDelegate = AppDelegate(router: spyRouter)


                let _ = appDelegate.application(
                    UIApplication.shared,
                    didFinishLaunchingWithOptions: nil
                )



                expect(spyRouter.setup_wasCalled)
                    .to(beTrue())
           }
        }
    }
}
