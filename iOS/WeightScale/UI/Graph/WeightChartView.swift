import Charts

final class WeightChartView: LineChartView {
    func chartViewConfiguration() {
        noDataText = "体重データがありません"

        dragConfiguration()
        layoutConfiguration()
        axisConfiguration()
    }

    func dragConfiguration() {
        dragDecelerationEnabled = true
        dragDecelerationFrictionCoef = 0.6
    }

    func layoutConfiguration() {
        extraTopOffset = 24.0
        extraLeftOffset = 12.0
        extraRightOffset = 24.0
        extraBottomOffset = 18.0

        legend.drawInside = true
        legend.verticalAlignment = .top
    }

    func axisConfiguration() {
        xAxis.enabled = false
        rightAxis.enabled = false
        leftAxis.labelTextColor = UIColor.text.inputField
    }

    func drawChart(weightDataList: [WeightData], targetWeight: Double) {
        var dataForWeight: [Double] = []
        var daysForXAxis: [String] = []
        var intervalList: [Double] = []

        var dataForTargetWeight: [Double] = []
        var minValue: Double = -1.0

        weightDataList.forEach { weightData in
            dataForWeight.append(weightData.weight)
            daysForXAxis.append(weightData.dateString)

            dataForTargetWeight.append(targetWeight)

            if minValue < 0 {
                minValue = weightData.dateString.toDate(format: "yyyy/MM/dd")!.timeIntervalSince1970
            }
            intervalList.append(weightData.dateString.toDate(format: "yyyy/MM/dd")!.timeIntervalSince1970 - minValue)

        }

        xAxis.valueFormatter
            = IndexAxisValueFormatter(values: daysForXAxis)

        //        setXformatter(minTimeInterval: intervalList[0])

        var weightEntries = [ChartDataEntry]()
        for (i, d) in dataForWeight.enumerated() {
            weightEntries.append(ChartDataEntry(x: intervalList[i], y: d))
        }

        let weightDataSet
            = LineChartDataSet(entries: weightEntries, label: "記録")
        weightDataSet.drawFilledEnabled = true
        weightDataSet.fillColor = UIColor.graph.weightFill

        weightDataSet.setColor(UIColor.graph.weightLine)
        weightDataSet.circleRadius = 6.0
        weightDataSet.setCircleColor(UIColor.graph.weightLine)
        weightDataSet.lineWidth = 6.0
        weightDataSet.valueTextColor = UIColor.text.inputField

        var targetWeightEntries = [ChartDataEntry]()
        for (i, d) in dataForTargetWeight.enumerated() {
            targetWeightEntries.append(ChartDataEntry(x: intervalList[i], y: d))
        }

        let targetWeightDataSet
            = LineChartDataSet(entries: targetWeightEntries, label: "目標体重")

        targetWeightDataSet.setColor(UIColor.graph.targetWeightLine)
        targetWeightDataSet.drawCirclesEnabled = false
        targetWeightDataSet.drawValuesEnabled = false
        targetWeightDataSet.lineWidth = 6.0


        var dataSets = [LineChartDataSet]()
        dataSets.append(weightDataSet)

        if targetWeight != 0.0 {
            dataSets.append(targetWeightDataSet)
        }

        data = LineChartData(dataSets: dataSets)

        drawAnimation()
    }

    func drawAnimation() {
        animate(xAxisDuration: 1.0)
    }

//    func setXformatter(minTimeInterval: Double) {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .none
//        formatter.timeStyle = .none
//        formatter.locale = Locale.current
//        let xValueNumberFormatter = ChartXAxisFormatter(referenceTimeInterval: minTimeInterval, dateFormatter: formatter)
//        xAxis.valueFormatter = xValueNumberFormatter as! IAxisValueFormatter
//    }
}

extension String {
    func toDate(format: String) ->Date? {
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
}

//class ChartXAxisFormatter: NSObject {
//    fileprivate var dateFormatter: DateFormatter?
//    fileprivate var referenceTimeInterval: TimeInterval?
//
//    convenience init(referenceTimeInterval: TimeInterval, dateFormatter: DateFormatter) {
//        self.init()
//        self.referenceTimeInterval = referenceTimeInterval
//        self.dateFormatter = dateFormatter
//    }
//}

//extension ChartXAxisFormatter: IAxisValueFormatter {
//
//    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
//        guard let dateFormatter = dateFormatter,
//              let referenceTimeInterval = referenceTimeInterval
//        else {
//            return ""
//        }
//
//        let date = Date(timeIntervalSince1970: value + referenceTimeInterval)
//        return dateFormatter.string(from: date)
//    }
//}
