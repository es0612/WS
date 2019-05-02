import Nimble
import Quick
import Succinct

import Charts

@testable import WeightScale

class GraphViewControllerSpec: QuickSpec {
    override func spec() {
        describe("graph view controller に関するテスト") {
            var graphViewController: GraphViewController!

            beforeEach {
                graphViewController = GraphViewController()
            }

            it("タイトルが見える") {
                expect(graphViewController.title)
                    .to(equal("グラフ"))
            }

            it("グラフが見える") {
                expect(graphViewController.hasLineChartView())
                    .to(beTrue())
            }
        }
    }
}
