import UIKit
import Charts

class GraphViewController: UIViewController {
    // MARK: - Views
    var chartView: LineChartView

    // MARK: - Properties
    private var didSetupConstraints: Bool = false

    // MARK: - Initialization
    init() {
        chartView = LineChartView()


        super.init(nibName: nil, bundle: nil)


        addSubviews()
        viewConfigurations()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateViewConstraints() {
        if didSetupConstraints == false {
            chartView.autoPinEdgesToSuperviewEdges()

            didSetupConstraints = true
        }

        super.updateViewConstraints()
    }

}

// MARK: - Private methods
fileprivate extension GraphViewController {
    func addSubviews(){
        view.addSubview(chartView)
    }

    func viewConfigurations() {
        title = "グラフ"
        view.backgroundColor = .white

        chartView.noDataText = "体重データがありません"
        updateViewConstraints()

    }
}
