import UIKit

class NotificationSectionView: TemplateView {
    // MARK: - Views
    private let sectionLabel: UILabel
    private let notificationOnOffLabel: UILabel
    private let notificationSwitch: UISwitch
    private let notificationTimeButton: UIButton
    private let notificationTimeLabel: UILabel

    // MARK: - Initialization
    override init(frame: CGRect) {
        sectionLabel = UILabel.newAutoLayout()
        notificationOnOffLabel = UILabel.newAutoLayout()
        notificationSwitch = UISwitch.newAutoLayout()
        notificationTimeButton = UIButton(type: .system)
        notificationTimeLabel = UILabel.newAutoLayout()

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

        notificationOnOffLabel.autoPinEdge(.top, to: .bottom, of: sectionLabel)
        notificationOnOffLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 18.0)

        notificationSwitch.autoPinEdge(.top, to: .bottom, of: sectionLabel)
        notificationSwitch.autoPinEdge(toSuperviewEdge: .right, withInset: 18.0)

        notificationTimeButton.autoPinEdge(.top, to: .bottom, of: notificationOnOffLabel)
        notificationTimeButton.autoPinEdge(toSuperviewEdge: .left, withInset: 18.0)
        notificationTimeButton.autoPinEdge(toSuperviewEdge: .right, withInset: 18.0)
        notificationTimeButton.autoPinEdge(toSuperviewEdge: .bottom)

        notificationTimeLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 18.0)
        notificationTimeLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
    }

    override func addSubviews() {
        addSubview(sectionLabel)
        addSubview(notificationOnOffLabel)
        addSubview(notificationSwitch)
        addSubview(notificationTimeButton)

        notificationTimeButton.addSubview(notificationTimeLabel)
    }

    override func viewConfigurations() {
        sectionLabel.text = "通知"

        notificationOnOffLabel.text = "ON/OFF"

        notificationTimeButton.setTitle("通知時間", for: .normal)
        notificationTimeButton.contentHorizontalAlignment = .left

        notificationTimeLabel.text = "17:00"
    }
}
