import UIKit

class TargetWeightView: TemplateView {
    // MARK: - Views
    var targetWeightLabel: UILabel
    var targetWeightValueLabel: UILabel
    var valueBackgroundView: UIView

    override init(frame: CGRect) {
        targetWeightLabel = UILabel.newAutoLayout()
        targetWeightValueLabel = UILabel.newAutoLayout()
        valueBackgroundView = UIView.newAutoLayout()

        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func configureConstraints() {
        autoSetDimension(.height, toSize: 36.0)

        targetWeightLabel
            .autoPinEdge(toSuperviewEdge: .left, withInset: 24.0)
        targetWeightLabel.autoPinEdge(toSuperviewEdge: .top)
        targetWeightLabel.autoPinEdge(toSuperviewEdge: .bottom)

        targetWeightValueLabel.autoPinEdge(.left, to: .right, of: targetWeightLabel, withOffset: 0.0)
        targetWeightValueLabel
            .autoPinEdge(toSuperviewEdge: .right, withInset: 24.0)
        targetWeightValueLabel.autoPinEdge(toSuperviewEdge: .top)
        targetWeightValueLabel.autoPinEdge(toSuperviewEdge: .bottom)

        valueBackgroundView.autoPinEdge(toSuperviewEdge: .top)
        valueBackgroundView.autoPinEdge(toSuperviewEdge: .right)
        valueBackgroundView.autoPinEdge(toSuperviewEdge: .bottom)
        valueBackgroundView.autoSetDimension(.width, toSize: (superview?.frame.width)! / 2.0)
    }

    override func addSubviews() {
        addSubview(valueBackgroundView)

        addSubview(targetWeightLabel)
        addSubview(targetWeightValueLabel)

    }

    override func viewConfigurations() {
        targetWeightLabel.text = "目標体重"
    }

    override func applyStyles() {
        targetWeightLabel.textColor = UIColor.text.date
        targetWeightLabel.font = UIFont.header

        targetWeightValueLabel.textColor = UIColor.text.inputField
        targetWeightValueLabel.font = UIFont.value

        valueBackgroundView.backgroundColor = UIColor.graph.weightFill
    }

    func refreshData(targetWeight: Double) {
        targetWeightValueLabel.text = String(
            format: "%.1f", targetWeight
            ) + " kg"
    }
}
