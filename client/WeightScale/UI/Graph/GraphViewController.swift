import UIKit

class GraphViewController: TemplateViewController {
    // MARK: - Injected Dependencies
    private var weightRepository: WeightRepository
    private var targetWeightRepository: TargetWeightRepository

    // MARK: - Views
    var targetWeightView: TargetWeightView
    var chartView: WeightChartView

    // MARK: - Initialization
    init(weightRepository: WeightRepository,
         targetWeightRepository: TargetWeightRepository) {
        self.weightRepository = weightRepository
        self.targetWeightRepository = targetWeightRepository

        chartView = WeightChartView.newAutoLayout()
        targetWeightView = TargetWeightView()

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

        targetWeightView.refreshData(targetWeight: targetWeight)
    }

    override func configureConstraints() {
        chartView
            .autoPinEdge(toSuperviewSafeArea: .top, withInset: 12.0)
        chartView
            .autoPinEdge(toSuperviewSafeArea: .left)
        chartView
            .autoPinEdge(toSuperviewSafeArea: .right)

        targetWeightView.autoPinEdge(.top, to: .bottom, of: chartView, withOffset: 12.0)
        targetWeightView.autoPinEdge(toSuperviewSafeArea: .left)
        targetWeightView.autoPinEdge(toSuperviewSafeArea: .right)
        targetWeightView.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 24.0)
    }

    override func addSubviews(){
        view.addSubview(chartView)
        view.addSubview(targetWeightView)
    }

    override func viewConfigurations() {
        title = "グラフ"
        view.backgroundColor = .white

        chartView.chartViewConfiguration()
    }

    override func applyStyles() {
        view.backgroundColor = UIColor.background.main
        targetWeightView.backgroundColor = UIColor.background.tableCell
    }
}
