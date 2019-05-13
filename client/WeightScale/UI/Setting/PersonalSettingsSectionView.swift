import UIKit

class PersonalSettingsSectionView: TemplateView {
    // MARK: - Views
    private let sectionLabel: UILabel
    private let headerButton: UIButton
    private let valueLabel: UILabel

    // MARK: - Initialization
    override init(frame: CGRect) {
        sectionLabel = UILabel.newAutoLayout()
        headerButton = UIButton(type: .system)
        valueLabel = UILabel.newAutoLayout()

        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override Methods
    override func configureConstraints() {
        autoSetDimension(.height, toSize: 60.0)

        sectionLabel.autoPinEdge(toSuperviewEdge: .top)
        sectionLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 18.0)

        headerButton.autoPinEdge(.top, to: .bottom, of: sectionLabel, withOffset: 12.0)
        headerButton.autoPinEdge(toSuperviewEdge: .left, withInset: 18.0)
        headerButton.autoPinEdge(toSuperviewEdge: .right, withInset: 18.0)
        headerButton.autoPinEdge(toSuperviewEdge: .bottom)

        valueLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 18.0)
        valueLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
    }

    override func addSubviews() {
        addSubview(sectionLabel)
        addSubview(headerButton)

        headerButton.addSubview(valueLabel)
    }

    override func viewConfigurations() {
        sectionLabel.text = "個人設定"

        headerButton.contentHorizontalAlignment = .left
        headerButton.setTitle("目標体重", for: .normal)

        headerButton.addTarget(superview, action: #selector(SettingViewController.didTapTargetWeightButton), for: .touchUpInside)
    }
}

// MARK: - Public Methods
extension PersonalSettingsSectionView {
    func setValueLabel(value: String) {
        valueLabel.text = value
    }
}
