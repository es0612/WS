import Nimble
import Quick

import Charts
import PureLayout

class ChartsSpec: QuickSpec {

    override func spec() {
        describe("Chartsに関するテスト") {
            it("chartsの基本設定を確認する"){
                let chartView = LineChartView.newAutoLayout()

                var entries = [ChartDataEntry]()
                let data = [2.0, 4.0, 6.0, 8.0, 10.0]
                for (i, d) in data.enumerated() {
                    entries.append(ChartDataEntry(x: Double(i), y: d ))
                }

                let dataSet = LineChartDataSet(entries: entries, label: "test")

                chartView.data = LineChartData(dataSet: dataSet)


                expect(chartView.lineData?.entryCount).to(equal(5))
            }
        }
    }
}
