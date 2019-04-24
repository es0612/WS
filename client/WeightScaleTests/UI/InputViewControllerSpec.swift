import Nimble
import Quick
import Succinct

@testable import WeightScale

class InputViewControllerSpec: QuickSpec {
    override func spec() {
        describe("Input view controller に関するテスト") {
            var spyRouter: SpyRouter!
            var inputViewController: InputViewController!

            beforeEach {
                spyRouter = SpyRouter()
                inputViewController = InputViewController(router: spyRouter)
            }

            it("OKボタンが見える") {
                expect(inputViewController
                    .hasButton(withExactText: "OK"))
                    .to(beTrue())
            }

            it("入力欄が見える") {
                expect(inputViewController
                    .hasTextField(withExactPlaceholderText: "00.0"))
                    .to(beTrue())
            }

            it("kgのラベルが見える") {
                expect(inputViewController
                    .hasLabel(withExactText: "kg"))
                    .to(beTrue())
            }

            it("体重を入力するとき数字で入力できる") {
                let inputTextField = inputViewController
                    .findTextField(withExactPlaceholderText: "00.0")


                expect(inputTextField?.keyboardType).to(equal(.numberPad))
            }

            it("OKボタンをタップしたとき,メイン画面に遷移する") {
                inputViewController.tapButton(withExactText: "OK")


                expect(spyRouter.showMainTabBarScreen_wasCalled).to(beTrue())

            }
        }
    }
}

