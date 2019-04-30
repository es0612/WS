import Nimble
import Quick
import Succinct

import Charts

@testable import WeightScale

class GraphViewControllerSpec: QuickSpec {
    override func spec() {
        describe("graph view controller に関するテスト") {
            it("タイトルが見える") {
                let graphViewController = GraphViewController()


                expect(graphViewController.title).to(equal("グラフ"))
            }

            it("グラフが見える") {
                let graphViewController = GraphViewController()


                expect(graphViewController.hasLineChartView()).to(beTrue())
            }
        }
    }
}

extension UIView {
    public func findLineChartView() -> LineChartView? {
        for subview in subviews {
            if let lineChartView = subview as? LineChartView {
                return lineChartView
            }

            if let lineChartView = subview.findLineChartView() {
                return lineChartView
            }
        }

        return nil
    }
}

extension UIViewController {
    public func hasLineChartView() -> Bool {
        return view.findLineChartView().isNotNil()
    }
}
