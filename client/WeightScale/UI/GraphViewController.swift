import UIKit
import Charts

class GraphViewController: TemplateViewController {
    // MARK: - Injected Dependencies
    private var weightRepository: WeightRepository

    // MARK: - Views
    var chartView: LineChartView

    // MARK: - Initialization
    init(weightRepository: WeightRepository) {
        self.weightRepository = weightRepository

        chartView = LineChartView()

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
        chartView.autoPinEdgesToSuperviewSafeArea()
    }

    override func addSubviews(){
        view.addSubview(chartView)
    }

    override func viewConfigurations() {
        title = "グラフ"
        view.backgroundColor = .white

        chartViewConfiguration()

    }
}

// MARK: - Private methods
fileprivate extension GraphViewController {
    func chartViewConfiguration() {
        chartView.noDataText = "体重データがありません"
    }

    func drawChart(weightDataList: [WeightData]) {
        var dataForChart: [Double] = []
        weightDataList.forEach { weightData in
            dataForChart.append(weightData.weight)
        }

        var entries = [ChartDataEntry]()
        for (i, d) in dataForChart.enumerated() {
            entries.append(ChartDataEntry(x: Double(i), y: d))
        }

        let dataSet = LineChartDataSet(entries: entries, label: "my weight")

        chartView.data = LineChartData(dataSet: dataSet)
    }
}
