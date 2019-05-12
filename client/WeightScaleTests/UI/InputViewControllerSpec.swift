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

            it("タイトルが見える") {
                expect(inputViewController.title).to(equal("入力"))
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

            describe("ナビゲーションバーについて") {
                var barButtonItem: UIBarButtonItem!

                beforeEach {
                    barButtonItem = inputViewController
                        .navigationItem
                        .leftBarButtonItem
                }

                it("キャンセルボタンが見える") {
                    expect(barButtonItem!.title).to(equal("キャンセル"))
                }

                it("キャンセルボタンを押すとリスト画面が見える") {
                    barButtonItem?.tap()


                    expect(spyRouter.dismissInputScreen_wasCalled)
                        .to(beTrue())
                }
            }

            describe("体重入力欄について") {
                var inputTextField: UITextField!

                beforeEach {
                    inputTextField = inputViewController
                        .findTextField(withExactPlaceholderText: "00.0")
                }

                it("入力欄にデフォルト初期値が見える") {
                    stubWeightRepository
                        .getMostRecentWeight_returnValue = nil


                    inputViewController.viewDidLoad()


                    expect(inputTextField?.text).to(equal("50.0"))
                }

                it("入力欄に初期値として直近の体重が見える") {
                    stubWeightRepository
                        .getMostRecentWeight_returnValue = 51.0


                    inputViewController.viewDidLoad()


                    expect(inputTextField?.text).to(equal("51.0"))
                }

                it("体重を入力するときpickerで入力できる") {
                    expect(inputTextField?.inputView)
                        .to(beAKindOf(UIPickerView.self))
                }

                context("体重を入力して、OKボタンをタップしたとき") {
                    beforeEach {
                        inputTextField?.text = "50.0"

                        inputViewController.tapButton(withExactText: "OK")
                    }

                    it("データを保存する") {
                        expect(stubWeightRepository.saveData_argutment_weight)
                            .to(equal(50.0))
                    }

                    it("メイン画面に遷移する") {
                        expect(spyRouter.dismissInputScreen_wasCalled).to(beTrue())
                    }
                }

                context("体重を入力しないで、OKボタンをタップしたとき") {
                    beforeEach {
                        inputTextField?.text = ""

                        inputViewController.tapButton(withExactText: "OK")
                    }

                    it("データを保存しない") {
                        expect(stubWeightRepository.saveData_argutment_weight)
                            .to(equal(-1.0))
                    }

                    it("メイン画面に遷移しない") {
                        expect(spyRouter.dismissInputScreen_wasCalled).to(beFalse())
                    }
                }
            }
        }
    }
}

