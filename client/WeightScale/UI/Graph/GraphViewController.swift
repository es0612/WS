import UIKit

class GraphViewController: TemplateViewController {
    // MARK: - Injected Dependencies
    private var weightRepository: WeightRepository
    private var targetWeightRepository: TargetWeightRepository

    // MARK: - Views
    var chartView: WeightChartView
    var targetWeightLabel: UILabel
    var targetWeightValueLabel: UILabel

    // MARK: - Initialization
    init(weightRepository: WeightRepository,
         targetWeightRepository: TargetWeightRepository) {
        self.weightRepository = weightRepository
        self.targetWeightRepository = targetWeightRepository

        chartView = WeightChartView.newAutoLayout()
        targetWeightLabel = UILabel.newAutoLayout()
        targetWeightValueLabel = UILabel.newAutoLayout()

        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override Methods
    override func viewWillAppear(_ animated: Bool) {
        let weightDataList
            = weightRepository.loadData()
        let targetWeight = targetWeightRepository.loadTargetWeight()

        chartView.drawChart(
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
            .autoPinEdge(.top, to: .bottom, of: chartView, withOffset: 10.0)
        targetWeightLabel
            .autoPinEdge(toSuperviewSafeArea: .left)
        targetWeightLabel
            .autoPinEdge(toSuperviewSafeArea: .right)
        targetWeightLabel
            .autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 10.0)


        targetWeightValueLabel.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .left)
    }

    override func addSubviews(){
        view.addSubview(chartView)
        view.addSubview(targetWeightLabel)
        
        targetWeightLabel.addSubview(targetWeightValueLabel)
    }

    override func viewConfigurations() {
        title = "グラフ"
        view.backgroundColor = .white

        chartView.chartViewConfiguration()

        targetWeightLabel.text = "目標体重"

    }

    override func applyStyles() {
        view.backgroundColor = UIColor.background.main
    }
}
