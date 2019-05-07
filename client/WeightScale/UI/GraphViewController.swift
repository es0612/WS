import UIKit
import Charts

class GraphViewController: TemplateViewController {
    // MARK: - Injected Dependencies
    private var weightRepository: WeightRepository
    private var targetWeightRepository: TargetWeightRepository

    // MARK: - Views
    var chartView: LineChartView
    var targetWeightLabel: UILabel
    var targetWeightValueLabel: UILabel

    // MARK: - Initialization
    init(weightRepository: WeightRepository,
         targetWeightRepository: TargetWeightRepository) {
        self.weightRepository = weightRepository
        self.targetWeightRepository = targetWeightRepository

        chartView = LineChartView.newAutoLayout()
        targetWeightLabel = UILabel.newAutoLayout()
        targetWeightValueLabel = UILabel.newAutoLayout()

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

        targetWeightValueLabel.text = String(
            format: "%.1f",
            targetWeightRepository.loadTargetWeight()
        )
    }

    override func configureConstraints() {
        chartView.autoPinEdgesToSuperviewSafeArea(
            with: .zero, excludingEdge: .bottom
        )

        targetWeightLabel
            .autoPinEdge(.top, to: .bottom, of: chartView)
        targetWeightLabel
            .autoPinEdge(toSuperviewSafeArea: .left)
        targetWeightLabel
            .autoPinEdge(toSuperviewSafeArea: .bottom)

        targetWeightValueLabel
            .autoPinEdge(.top, to: .bottom, of: chartView)
        targetWeightValueLabel
            .autoPinEdge(.left, to: .right, of: targetWeightLabel)
        targetWeightValueLabel
            .autoPinEdge(toSuperviewSafeArea: .right)
        targetWeightValueLabel
            .autoPinEdge(toSuperviewSafeArea: .bottom)
    }

    override func addSubviews(){
        view.addSubview(chartView)
        view.addSubview(targetWeightLabel)
        view.addSubview(targetWeightValueLabel)
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
