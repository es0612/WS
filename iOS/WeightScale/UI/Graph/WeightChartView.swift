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

        var dataForTargetWeight: [Double] = []

        weightDataList.forEach { weightData in
            dataForWeight.append(weightData.weight)
            daysForXAxis.append(weightData.dateString)

            dataForTargetWeight.append(targetWeight)
        }

        xAxis.valueFormatter
            = IndexAxisValueFormatter(values: daysForXAxis)


        var weightEntries = [ChartDataEntry]()
        for (i, d) in dataForWeight.enumerated() {
            weightEntries.append(ChartDataEntry(x: Double(i), y: d))
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
        if weightDataSet.count > 7 {
            weightDataSet.drawValuesEnabled = false
        }


        var targetWeightEntries = [ChartDataEntry]()
        for (i, d) in dataForTargetWeight.enumerated() {
            targetWeightEntries.append(ChartDataEntry(x: Double(i), y: d))
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
}
