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
            var inputTextField: UITextField!

            beforeEach {
                spyRouter = SpyRouter()
                stubWeightRepository = StubWeightRepository()
                inputViewController = InputViewController(
                    router: spyRouter,
                    weightRepository: stubWeightRepository)


                inputViewController.viewWillAppear(false)

                inputTextField = inputViewController
                    .findTextField(withExactPlaceholderText: "00.0")
            }

            it("タイトルが見える") {
                expect(inputViewController.title).to(equal("入力"))
            }

            it("今日の日付が見える") {
                expect(inputViewController
                    .hasLabel(withExactText: DateManager.getToday())).to(beTrue())
            }

            it("OKボタンが見える") {
                expect(inputViewController
                    .hasButton(withExactText: "O K"))
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
                    expect(barButtonItem!.title).to(equal("< キャンセル"))
                }

                it("キャンセルボタンを押すとピッカーが見えなくなる") {
                    barButtonItem?.tap()


                    expect(inputTextField.isFirstResponder)
                        .to(beFalse())
                }

                it("キャンセルボタンを押すとリスト画面が見える") {
                    barButtonItem?.tap()


                    expect(spyRouter.dismissInputScreen_wasCalled)
                        .to(beTrue())
                }
            }

            describe("体重入力欄について") {
                it("入力欄にデフォルト初期値が見える") {
                    stubWeightRepository
                        .getMostRecentWeight_returnValue = nil


                    inputViewController.viewWillAppear(false)


                    expect(inputTextField?.text).to(equal("50.0"))
                }

                it("入力欄に初期値として直近の体重が見える") {
                    stubWeightRepository
                        .getMostRecentWeight_returnValue = 51.0


                    inputViewController.viewWillAppear(false)


                    expect(inputTextField?.text).to(equal("51.0"))
                }

                it("体重を入力するときpickerで入力できる") {
                    expect(inputTextField?.inputView)
                        .to(beAKindOf(UIPickerView.self))
                }

                it("ピッカーの初期値に直近の体重が見える") {
                    let pickerView = inputTextField.inputView as? WeightPickerView
                    stubWeightRepository
                        .getMostRecentWeight_returnValue = 50.3


                    inputViewController.viewWillAppear(false)


                    let actualWeight = WeightPickerView
                        .Constants
                        .pickerDataArray[(pickerView?.selectedRow)!]
                    expect(actualWeight).to(equal(50.3))
                }

                context("体重を入力して、OKボタンをタップしたとき") {
                    beforeEach {
                        inputTextField?.text = "50.0"

                        inputViewController.tapButton(withExactText: "O K")
                    }

                    it("データを保存する") {
                        expect(stubWeightRepository.saveData_argutment_weight)
                            .to(equal(50.0))
                    }

                    it("メイン画面に遷移する") {
                        expect(spyRouter.dismissInputScreen_wasCalled)
                            .to(beTrue())
                    }
                }

                context("体重を入力しないで、OKボタンをタップしたとき") {
                    beforeEach {
                        inputTextField?.text = ""

                        inputViewController.tapButton(withExactText: "O K")
                    }

                    it("データを保存しない") {
                        expect(stubWeightRepository.saveData_argutment_weight)
                            .to(equal(-1.0))
                    }

                    it("メイン画面に遷移しない") {
                        expect(spyRouter.dismissInputScreen_wasCalled)
                            .to(beFalse())
                    }
                }
            }
        }
    }
}

