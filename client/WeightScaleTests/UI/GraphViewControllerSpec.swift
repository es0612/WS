import Nimble
import Quick
import Succinct

@testable import WeightScale

class GraphViewControllerSpec: QuickSpec {
    override func spec() {
        describe("graph view controller に関するテスト") {
            it("タイトルが見える") {
                let graphViewController = GraphViewController()


                expect(graphViewController.title).to(equal("グラフ"))
            }
        }
    }
}


