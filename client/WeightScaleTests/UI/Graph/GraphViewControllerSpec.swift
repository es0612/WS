import Nimble
import Quick
import Succinct

import Charts

@testable import WeightScale

class GraphViewControllerSpec: QuickSpec {
    override func spec() {
        describe("graph view controller に関するテスト") {
            var stubWeightRepository: StubWeightRepository!
            var graphViewController: GraphViewController!

            beforeEach {
                stubWeightRepository = StubWeightRepository()
            }

            describe("体重データがあるとき") {
                beforeEach {
                    let expectedWeightData = WeightData()
                    expectedWeightData.dateString = "2019/5/1"
                    expectedWeightData.weight = 50.0

                    stubWeightRepository.loadData_returnValue =
                        [expectedWeightData]

                    graphViewController = GraphViewController(weightRepository: stubWeightRepository)
                }

                it("タイトルが見える") {
                    expect(graphViewController.title)
                        .to(equal("グラフ"))
                }

                it("グラフが見える") {
                    expect(graphViewController.hasLineChartView())
                        .to(beTrue())
                }

                it("体重データを読み込んで表示する") {
                    expect(stubWeightRepository.loadData_wasCalled)
                        .to(beTrue())


                    let chartView
                        = graphViewController.view.findLineChartView()
                    expect(chartView?.lineData?.entryCount)
                        .to(equal(1))
                }
            }

            describe("体重データがないとき") {
                beforeEach {
                    stubWeightRepository.loadData_returnValue = []

                    graphViewController = GraphViewController(weightRepository: stubWeightRepository)
                }
                
                it("体重データを読み込む") {
                    expect(stubWeightRepository.loadData_wasCalled)
                        .to(beTrue())
                }

                it("データがない旨を表示") {
                    let chartView
                        = graphViewController.view.findLineChartView()
                    expect(chartView?.lineData?.entryCount)
                        .to(equal(0))
                }
            }
        }
    }
}
