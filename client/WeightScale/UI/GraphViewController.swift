import UIKit
import Charts

class GraphViewController: TemplateViewController {
    // MARK: - Views
    var chartView: LineChartView

    // MARK: - Initialization
    override init() {
        chartView = LineChartView()


        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func configureConstraints() {
        chartView.autoPinEdgesToSuperviewEdges()
    }

    override func addSubviews(){
        view.addSubview(chartView)
    }

    override func viewConfigurations() {
        title = "グラフ"
        view.backgroundColor = .white

        chartView.noDataText = "体重データがありません"
        updateViewConstraints()

    }

}

// MARK: - Private methods
fileprivate extension GraphViewController {
}
