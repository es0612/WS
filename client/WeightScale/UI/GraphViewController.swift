import UIKit
import Charts

class GraphViewController: TemplateViewController {
    // MARK: - Injected Dependencies
    private var weightRepository: WeightRepository

    // MARK: - Views
    var chartView: LineChartView
    var targetWeightLabel: UILabel

    // MARK: - Initialization
    init(weightRepository: WeightRepository) {
        self.weightRepository = weightRepository

        chartView = LineChartView.newAutoLayout()
        targetWeightLabel = UILabel.newAutoLayout()

        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override Methods
    override func viewDidLoad() {
        let weightDataList
            = weightRepository.loadData()

        drawChart(weightDataList: weightDataList)

    }

    override func configureConstraints() {
        chartView.autoPinEdgesToSuperviewSafeArea(
            with: .zero, excludingEdge: .bottom
        )

        targetWeightLabel
            .autoPinEdge(.top, to: .bottom, of: chartView)
        targetWeightLabel
            .autoPinEdgesToSuperviewSafeArea(
                with: .zero, excludingEdge: .top
        )
    }

    override func addSubviews(){
        view.addSubview(chartView)
        view.addSubview(targetWeightLabel)
    }

    override func viewConfigurations() {
        title = "グラフ"
        view.backgroundColor = .white

        chartViewConfiguration()

        targetWeightLabel.text = "目標体重"

    }
}

// MARK: - Private methods
fileprivate extension GraphViewController {
    func chartViewConfiguration() {
        chartView.noDataText = "体重データがありません"

        chartView.xAxis.labelPosition = .bottom
        chartView.rightAxis.enabled = false

        chartView.xAxis.granularity = 1

        let rotationAngle = 40
        chartView.xAxis.labelRotationAngle = .init(rotationAngle)

        chartView.legend.drawInside = true
        chartView.legend.verticalAlignment = .top
    }

    func drawChart(weightDataList: [WeightData]) {
        var dataForChart: [Double] = []
        var daysForXAxis: [String] = []

        weightDataList.forEach { weightData in
            dataForChart.append(weightData.weight)
            daysForXAxis.append(weightData.dateString)
        }

        chartView.xAxis.valueFormatter
            = IndexAxisValueFormatter(values: daysForXAxis)


        var entries = [ChartDataEntry]()
        for (i, d) in dataForChart.enumerated() {
            entries.append(ChartDataEntry(x: Double(i), y: d))
        }

        let dataSet = LineChartDataSet(entries: entries, label: "my weight")

        dataSet.mode = .cubicBezier
        dataSet.drawFilledEnabled = true

        chartView.data = LineChartData(dataSet: dataSet)
    }
}
