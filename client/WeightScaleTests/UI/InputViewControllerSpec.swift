import Nimble
import Quick
import Succinct

@testable import WeightScale

class InputViewControllerSpec: QuickSpec {
    override func spec() {
        describe("Input view controller に関するテスト") {
            var spyRouter: SpyRouter!
            var stubWeightRepository: StubWeightRepository!
            var inputViewController: InputViewController!

            beforeEach {
                spyRouter = SpyRouter()
                stubWeightRepository = StubWeightRepository()
                inputViewController = InputViewController(
                    router: spyRouter,
                    weightRepository: stubWeightRepository)
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

            it("体重を入力するときpickerで入力できる") {
                let inputTextField = inputViewController
                    .findTextField(withExactPlaceholderText: "00.0")


                expect(inputTextField?.inputView)
                    .to(beAKindOf(UIPickerView.self))
            }


            context("体重を入力して、OKボタンをタップしたとき") {
                beforeEach {
                    let inputTextField =
                        inputViewController.findTextField(
                            withExactPlaceholderText: "00.0"
                    )
                    inputTextField?.text = "50.0"

                    inputViewController.tapButton(withExactText: "OK")
                }

                it("データを保存する") {
                    expect(stubWeightRepository.saveData_argutment_weight)
                        .to(equal(50.0))
                }

                it("メイン画面に遷移する") {
                    expect(spyRouter.showMainTabBarScreen_wasCalled).to(beTrue())
                }
            }

            context("体重を入力しないで、OKボタンをタップしたとき") {
                beforeEach {
                    let inputTextField =
                        inputViewController.findTextField(
                            withExactPlaceholderText: "00.0"
                    )
                    inputTextField?.text = ""

                    inputViewController.tapButton(withExactText: "OK")
                }

                it("データを保存しない") {
                    expect(stubWeightRepository.saveData_argutment_weight)
                        .to(equal(-1.0))
                }

                it("メイン画面に遷移しない") {
                    expect(spyRouter.showMainTabBarScreen_wasCalled).to(beFalse())
                }
            }
        }
    }
}

