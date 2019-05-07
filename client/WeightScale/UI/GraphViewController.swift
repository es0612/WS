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
        let targetWeight = targetWeightRepository.loadTargetWeight()

        drawChart(
            weightDataList: weightDataList, targetWeight: targetWeight
        )

        targetWeightValueLabel.text = String(
            format: "%.1f", targetWeight
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

    func drawChart(weightDataList: [WeightData], targetWeight: Double) {
        var dataForWeight: [Double] = []
        var daysForXAxis: [String] = []

        var dataForTargetWeight: [Double] = []

        weightDataList.forEach { weightData in
            dataForWeight.append(weightData.weight)
            daysForXAxis.append(weightData.dateString)

            dataForTargetWeight.append(targetWeight)
        }

        chartView.xAxis.valueFormatter
            = IndexAxisValueFormatter(values: daysForXAxis)


        var weightEntries = [ChartDataEntry]()
        for (i, d) in dataForWeight.enumerated() {
            weightEntries.append(ChartDataEntry(x: Double(i), y: d))
        }

        let weightDataSet
            = LineChartDataSet(entries: weightEntries, label: "my weight")


        var targetWeightEntries = [ChartDataEntry]()
        for (i, d) in dataForTargetWeight.enumerated() {
            targetWeightEntries.append(ChartDataEntry(x: Double(i), y: d))
        }

        let targetWeightDataSet
            = LineChartDataSet(entries: targetWeightEntries, label: "target Weight")

        targetWeightDataSet.setColor(.green)
        targetWeightDataSet.setCircleColor(.green)


        var dataSets = [LineChartDataSet]()
        dataSets.append(weightDataSet)
        dataSets.append(targetWeightDataSet)

        chartView.data = LineChartData(dataSets: dataSets)
    }
}
