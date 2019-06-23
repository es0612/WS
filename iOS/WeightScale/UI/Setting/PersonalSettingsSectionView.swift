import UIKit

class PersonalSettingsSectionView: TemplateView {
    // MARK: - Views
    private let sectionLabel: UILabel
    private let headerButton: UIButton
    private let valueLabel: UILabel
    private let backgroundView: UIView

    // MARK: - Initialization
    override init(frame: CGRect) {
        sectionLabel = UILabel.newAutoLayout()
        headerButton = UIButton.newAutoLayout()
        valueLabel = UILabel.newAutoLayout()
        backgroundView = UIView.newAutoLayout()

        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override Methods
    override func configureConstraints() {
        autoSetDimension(.height, toSize: 72.0)

        sectionLabel.autoPinEdge(toSuperviewEdge: .top)
        sectionLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 18.0)

        backgroundView.autoSetDimension(.height, toSize: 36.0)
        backgroundView.autoPinEdge(.top, to: .bottom, of: sectionLabel)
        backgroundView.autoPinEdge(toSuperviewEdge: .left)
        backgroundView.autoPinEdge(toSuperviewEdge: .right)
        backgroundView.autoPinEdge(toSuperviewEdge: .bottom)

        headerButton.autoPinEdge(toSuperviewEdge: .top)
        headerButton.autoPinEdge(toSuperviewEdge: .left, withInset: 24.0)
        headerButton.autoPinEdge(toSuperviewEdge: .right, withInset: 24.0)
        headerButton.autoPinEdge(toSuperviewEdge: .bottom)

        valueLabel.autoPinEdge(toSuperviewEdge: .right)
        valueLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
    }

    override func addSubviews() {
        addSubview(sectionLabel)
        addSubview(backgroundView)

        backgroundView.addSubview(headerButton)
        headerButton.addSubview(valueLabel)
    }

    override func viewConfigurations() {
        sectionLabel.text = "個人設定"

        headerButton.contentHorizontalAlignment = .left
        headerButton.setTitle("目標体重", for: .normal)

        headerButton.addTarget(
            superview,
            action: #selector(SettingViewController.didTapTargetWeightButton),
            for: .touchUpInside
        )
    }

    override func applyStyles() {
        sectionLabel.textColor = UIColor.text.date
        sectionLabel.font = UIFont.section

        backgroundView.backgroundColor = UIColor.background.tableCell

        headerButton.setTitleColor(UIColor.text.date, for: .normal)
        headerButton.titleLabel?.font = UIFont.header

        valueLabel.textColor = UIColor.text.inputField
        valueLabel.font = UIFont.value

    }
}

// MARK: - Public Methods
extension PersonalSettingsSectionView {
    func setValueLabel(value: String) {
        valueLabel.text = value + " kg"
    }
}
