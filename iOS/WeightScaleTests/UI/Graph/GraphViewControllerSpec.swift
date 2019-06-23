import Nimble
import Quick
import Succinct

import Charts

@testable import WeightScale

class GraphViewControllerSpec: QuickSpec {
    override func spec() {
        describe("graph view controller に関するテスト") {
            var stubWeightRepository: StubWeightRepository!
            var stubTargetWeightRepository: StubTargetWeightRepository!
            var graphViewController: GraphViewController!

            beforeEach {
                stubWeightRepository
                    = StubWeightRepository()
                stubTargetWeightRepository
                    = StubTargetWeightRepository()
                stubTargetWeightRepository
                    .loadTargetWeight_returnValue = 40.0
            }

            describe("画面の基本情報の表示を確認") {
                beforeEach {
                    graphViewController = GraphViewController(
                        weightRepository: stubWeightRepository,
                        targetWeightRepository: stubTargetWeightRepository)

                    graphViewController.viewWillAppear(false)
                }

                it("タイトルが見える") {
                    expect(graphViewController.title)
                        .to(equal("グラフ"))
                }

                it("グラフが見える") {
                    expect(graphViewController.hasLineChartView())
                        .to(beTrue())
                }

                it("目標体重ラベルが見える") {
                    expect(graphViewController.hasLabel(withExactText: "目標体重"))
                        .to(beTrue())
                }

                it("目標体重の数値が見える") {
                    expect(stubTargetWeightRepository.loadTargetWeight_wasCalled)
                        .to(beTrue())
                    expect(graphViewController.hasLabel(withExactText: "40.0 kg"))
                        .to(beTrue())
                }
            }

            describe("体重データがあるとき") {
                beforeEach {
                    let expectedWeightData = WeightData()
                    expectedWeightData.dateString = "2019/5/1"
                    expectedWeightData.weight = 50.0

                    stubWeightRepository.loadData_returnValue =
                        [expectedWeightData]

                    graphViewController = GraphViewController(
                        weightRepository: stubWeightRepository,
                        targetWeightRepository: stubTargetWeightRepository)

                    graphViewController.viewWillAppear(false)
                }

                it("体重データを読み込む") {
                    expect(stubWeightRepository.loadData_wasCalled)
                        .to(beTrue())
                }

                it("体重データをグラフに表示する(目標体重も)") {
                    let chartView
                        = graphViewController.view.findLineChartView()
                    expect(chartView?.lineData?.entryCount)
                        .to(equal(2))
                }
            }

            describe("体重データがないとき") {
                beforeEach {
                    stubWeightRepository.loadData_returnValue = []

                    graphViewController = GraphViewController(
                        weightRepository: stubWeightRepository,
                        targetWeightRepository: stubTargetWeightRepository)

                    graphViewController.viewWillAppear(false)
                }
                
                it("体重データを読み込む") {
                    expect(stubWeightRepository.loadData_wasCalled)
                        .to(beTrue())
                }

                it("体重データがない旨を表示") {
                    let chartView
                        = graphViewController.view.findLineChartView()
                    expect(chartView?.lineData?.entryCount)
                        .to(equal(0))
                }
            }

            describe("体重データはあるが、目標体重が見設定の時") {
                beforeEach {
                    let expectedWeightData = WeightData()
                    expectedWeightData.dateString = "2019/5/1"
                    expectedWeightData.weight = 50.0

                    stubWeightRepository.loadData_returnValue =
                        [expectedWeightData]

                    stubTargetWeightRepository
                        .loadTargetWeight_returnValue = 0.0

                    graphViewController = GraphViewController(
                        weightRepository: stubWeightRepository,
                        targetWeightRepository: stubTargetWeightRepository)

                    graphViewController.viewWillAppear(false)
                }

                it("体重データのみ表示する") {
                    let chartView
                        = graphViewController.view.findLineChartView()
                    expect(chartView?.lineData?.entryCount)
                        .to(equal(1))
                }
            }
        }
    }
}
