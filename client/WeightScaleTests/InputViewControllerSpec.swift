import Nimble
import Quick
import Succinct

@testable import WeightScale

class InputViewControllerSpec: QuickSpec {
    override func spec() {
        describe("Input view controller に関するテスト") {
            it("OKボタンが見える") {
                let inputViewController = InputViewController()


                expect(inputViewController.hasButton(withExactText: "OK")).to(beTrue())
            }

            it("入力欄が見える") {
                let inputViewController = InputViewController()


                expect(inputViewController.hasTextField(withExactPlaceholderText: "00.0")).to(beTrue())
            }

            it("kgのラベルが見える") {
                let inputViewController = InputViewController()


                expect(inputViewController.hasLabel(withExactText: "kg")).to(beTrue())
            }

        }
    }
}

