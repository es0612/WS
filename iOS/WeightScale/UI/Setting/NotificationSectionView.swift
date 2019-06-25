import UIKit

protocol NotificationSectionViewDelegate {
    func setGrant()
    func getSettings() -> AuthorizationStatus
    func saveNotificationSwitchValue(value: Bool)
}

class NotificationSectionView: TemplateView {
    // MARK: - Views
    private let sectionLabel: UILabel
    private let notificationOnOffLabel: UILabel
    private let notificationSwitch: UISwitch
    private let notificationTimeButton: UIButton
    private let notificationTimeLabel: UILabel
    private let backgroundViewForSwitch: UIView
    private let backgroundViewForTime: UIView

    // MARK: - public properties
    var delegate: NotificationSectionViewDelegate? = nil

    // MARK: - Initialization
    override init(frame: CGRect) {
        sectionLabel = UILabel.newAutoLayout()
        notificationOnOffLabel = UILabel.newAutoLayout()
        notificationSwitch = UISwitch.newAutoLayout()
        notificationTimeButton = UIButton.newAutoLayout()
        notificationTimeLabel = UILabel.newAutoLayout()
        backgroundViewForSwitch = UIView.newAutoLayout()
        backgroundViewForTime = UIView.newAutoLayout()

        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override Methods
    override func configureConstraints() {
        autoSetDimension(.height, toSize: 108.0)

        sectionLabel.autoPinEdge(toSuperviewEdge: .top)
        sectionLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 18.0)

        backgroundViewForSwitch.autoSetDimension(.height, toSize: 36.0)
        backgroundViewForSwitch.autoPinEdge(.top, to: .bottom, of: sectionLabel)
        backgroundViewForSwitch.autoPinEdge(toSuperviewEdge: .left)
        backgroundViewForSwitch.autoPinEdge(toSuperviewEdge: .right)

        backgroundViewForTime.autoSetDimension(.height, toSize: 36.0)
        backgroundViewForTime.autoPinEdge(.top, to: .bottom, of: backgroundViewForSwitch)
        backgroundViewForTime.autoPinEdge(toSuperviewEdge: .left)
        backgroundViewForTime.autoPinEdge(toSuperviewEdge: .right)
        backgroundViewForTime.autoPinEdge(toSuperviewEdge: .bottom)


        notificationOnOffLabel.autoPinEdge(toSuperviewEdge: .top)
        notificationOnOffLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 24.0)
        notificationOnOffLabel.autoPinEdge(toSuperviewEdge: .bottom)

        notificationSwitch.autoPinEdge(toSuperviewEdge: .right, withInset: 24.0)
        notificationSwitch.autoAlignAxis(toSuperviewAxis: .horizontal)


        notificationTimeButton.autoPinEdge(toSuperviewEdge: .top)
        notificationTimeButton.autoPinEdge(toSuperviewEdge: .left, withInset: 24.0)
        notificationTimeButton.autoPinEdge(toSuperviewEdge: .right, withInset: 24.0)
        notificationTimeButton.autoPinEdge(toSuperviewEdge: .bottom)

        notificationTimeLabel.autoPinEdge(toSuperviewEdge: .right)
        notificationTimeLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
    }

    override func addSubviews() {
        addSubview(sectionLabel)
        addSubview(backgroundViewForSwitch)
        addSubview(backgroundViewForTime)

        backgroundViewForSwitch.addSubview(notificationOnOffLabel)
        backgroundViewForSwitch.addSubview(notificationSwitch)

        backgroundViewForTime.addSubview(notificationTimeButton)
        notificationTimeButton.addSubview(notificationTimeLabel)
    }

    override func viewConfigurations() {
        sectionLabel.text = "通知"

        notificationOnOffLabel.text = "通知OFF"

        notificationSwitch.addTarget(self, action: #selector(didTapNotificationSwitch), for: .touchUpInside)

        notificationTimeButton.setTitle("通知時間", for: .normal)
        notificationTimeButton.contentHorizontalAlignment = .left

        notificationTimeLabel.text = "17:00"
    }

    override func applyStyles() {
        sectionLabel.textColor = UIColor.text.date
        sectionLabel.font = UIFont.section

        backgroundViewForSwitch.backgroundColor = UIColor.background.tableCell
        backgroundViewForTime.backgroundColor = UIColor.background.tableCell
        backgroundViewForSwitch.layer.borderColor = UIColor.text.kg.cgColor

        notificationOnOffLabel.textColor = UIColor.text.date
        notificationOnOffLabel.font = UIFont.header

        notificationSwitch.onTintColor = UIColor.background.bar

        notificationTimeButton.setTitleColor(UIColor.text.date, for: .normal)
        notificationTimeButton.titleLabel?.font = UIFont.header

        notificationTimeLabel.textColor = UIColor.text.inputField
        notificationTimeLabel.font = UIFont.value

    }
}

// MARK: - Action
extension NotificationSectionView {
    @objc func didTapNotificationSwitch() {
        if notificationSwitch.isOn {

            delegate?.setGrant()

            let authorizationStatus = delegate?.getSettings()
            notificationSwitch
                .isEnabled = authorizationStatus?.isEnabled ?? false
            notificationSwitch
                .setOn(authorizationStatus?.isEnabled ?? false, animated: false)

            delegate?.saveNotificationSwitchValue(
                value: authorizationStatus?.isEnabled ?? false
            )
            
            if authorizationStatus?.isEnabled ?? false {
                notificationOnOffLabel.text = "通知ON"
            } else {
                notificationOnOffLabel.text = "通知OFF"
            }
            
        } else {
            notificationOnOffLabel.text = "通知OFF"
        }
    }
}

// MARK: - Public Methods
extension NotificationSectionView {
    func setNotificationSwitchValue(value: Bool) {
        notificationSwitch.setOn(value, animated: false)
    }
}
