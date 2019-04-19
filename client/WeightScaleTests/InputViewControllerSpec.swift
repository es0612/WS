import Nimble
import Quick
import Succinct

@testable import WeightScale

class InputViewControllerSpec: QuickSpec {
    override func spec() {
        describe("Input view controller に関するテスト") {
            var inputViewController: InputViewController!

            beforeEach {
                inputViewController = InputViewController()
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

        }
    }
}

