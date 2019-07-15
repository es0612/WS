import UIKit

class SettingViewController: TemplateViewController{
    // MARK: - Injected Dependencies
    private var targetWeightRepository: TargetWeightRepository
    private var notificationSender: NotificationSender
    private var notificationSwitchStatusRepository: NotificationSwitchStatusRepository
    private var notificationTimeRepository: NotificationTimeRepository

    // MARK: - Views
    private let settingStackView: UIStackView

    private let textFieldForPicker: UITextField
    private let targetWeightPicker: WeightPickerView
    private let targetWeightPickerToolbar: UIToolbar

    private let textFieldForTimePicker: UITextField
    private let notificationTimePicker: UIDatePicker
    private let notificationPickerToolbar: UIToolbar

    private let personalSettingsSectionView: PersonalSettingsSectionView
    private let notificationSectionView: NotificationSectionView

    // MARK: - Initialization
    init(targetWeightRepository: TargetWeightRepository,
         notificationSender: NotificationSender,
         notificationSwitchStatusRepository: NotificationSwitchStatusRepository,
         notificationTimeRepository: NotificationTimeRepository) {
        self.targetWeightRepository = targetWeightRepository
        self.notificationSender = notificationSender
        self.notificationSwitchStatusRepository = notificationSwitchStatusRepository
        self.notificationTimeRepository = notificationTimeRepository

        settingStackView = UIStackView.newAutoLayout()

        textFieldForPicker = UITextField.newAutoLayout()
        targetWeightPicker = WeightPickerView.newAutoLayout()
        targetWeightPickerToolbar = UIToolbar.newAutoLayout()

        textFieldForTimePicker = UITextField.newAutoLayout()
        notificationTimePicker = UIDatePicker.newAutoLayout()
        notificationPickerToolbar = UIToolbar.newAutoLayout()

        personalSettingsSectionView
            = PersonalSettingsSectionView.newAutoLayout()
        notificationSectionView
            = NotificationSectionView.newAutoLayout()

        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override Methods
    override func configureConstraints() {
        settingStackView
            .autoPinEdge(toSuperviewSafeArea: .top, withInset: 12.0)
        settingStackView.autoPinEdge(toSuperviewSafeArea: .left)
        settingStackView.autoPinEdge(toSuperviewSafeArea: .right)
    }

    override func viewWillAppear(_ animated: Bool) {
        let targetWeight
            = targetWeightRepository.loadTargetWeight()
        targetWeightPicker
            .selectRowFor(weight: targetWeight)
        personalSettingsSectionView
            .setValueLabel(value: String(format: "%.1f", targetWeight))

        let notificationSwitchValue
            = notificationSwitchStatusRepository.loadData()
        notificationSectionView
            .setNotificationSwitchValue(value: notificationSwitchValue)


        let authorizationStatus = notificationSender.getSettings()
        if authorizationStatus.isEnabled == false {
            notificationSectionView.setNotificationSettingAlertLabel(value: "通知を受け取るにはOSの通知設定をONにしてください")
        } else {
            notificationSectionView.setNotificationSettingAlertLabel(value: "")
        }

        if let notificationTime
            = notificationTimeRepository.loadTime() {
            notificationTimePicker
                .setDate(notificationTime, animated: false)
            notificationSectionView
                .setNotificationTimeLabel(
                    value: DateManager.convertTimeToString(time: notificationTime)
            )
        } else {
            notificationTimePicker.setDate(
                DateManager.convertStringToTime(string: "17:00"),
                animated: false
            )
            notificationSectionView.setNotificationTimeLabel(value: "17:00")
        }
    }

    override func addSubviews(){
        view.addSubview(textFieldForPicker)
        view.addSubview(textFieldForTimePicker)

        view.addSubview(settingStackView)

        settingStackView
            .addArrangedSubview(personalSettingsSectionView)
        settingStackView
            .addArrangedSubview(notificationSectionView)
        settingStackView.axis = .vertical
    }

    override func viewConfigurations() {
        title = "設定"

        textFieldForPickerConfiguration()
        pickerViewConfiguration()
        pickerToolbarConfiguration()

        notificationSectionView.delegate = self

        textFieldForTimePickerConfiguration()
        notificationTimePicker.datePickerMode = .time
        notificationPickerToolbarConfiguration()

    }

    override func applyStyles() {
        view.backgroundColor = UIColor.background.main

        targetWeightPicker.backgroundColor
            = UIColor.background.main
        targetWeightPickerToolbar.barTintColor
            = UIColor.background.bar

        notificationTimePicker.backgroundColor
            = UIColor.background.main
        notificationPickerToolbar.barTintColor
            = UIColor.background.bar

    }
}

// MARK: - Private Methods
private extension SettingViewController {
    func textFieldForPickerConfiguration() {
        textFieldForPicker.placeholder = "Target Weight"
        textFieldForPicker.isHidden = true
        textFieldForPicker.inputView = targetWeightPicker
        textFieldForPicker.inputAccessoryView = targetWeightPickerToolbar
    }

    func pickerViewConfiguration() {
        targetWeightPicker.dataSource = self
        targetWeightPicker.delegate = self
    }

    func pickerToolbarConfiguration() {
        targetWeightPickerToolbar.autoresizingMask = .flexibleHeight
        targetWeightPickerToolbar.barStyle = .default
        targetWeightPickerToolbar.isTranslucent = false

        let flexSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace, target: nil, action: nil
        )

        let doneButton = UIBarButtonItem(
            title: "OK",
            style: .done,
            target: self,
            action: #selector(didTapPickerDoneButton)
        )
        doneButton.tintColor = UIColor.white

        targetWeightPickerToolbar.items = [flexSpace, doneButton]
    }

    func textFieldForTimePickerConfiguration() {
        textFieldForTimePicker.placeholder = "Notification Time"
        textFieldForTimePicker.isHidden = true
        textFieldForTimePicker.inputView = notificationTimePicker
        textFieldForTimePicker.inputAccessoryView = notificationPickerToolbar
    }

    func notificationPickerToolbarConfiguration() {
        notificationPickerToolbar.autoresizingMask = .flexibleHeight
        notificationPickerToolbar.barStyle = .default
        notificationPickerToolbar.barTintColor = UIColor.lightGray
        notificationPickerToolbar.isTranslucent = false

        let flexSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace, target: nil, action: nil
        )

        let doneButton = UIBarButtonItem(
            title: "OK",
            style: .done,
            target: self,
            action: #selector(didTapTimePickerOkButton)
        )
        doneButton.tintColor = UIColor.white

        notificationPickerToolbar.items = [flexSpace, doneButton]
    }

    func getDateString(date: Date) -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "HH:mm"
        return dateformatter.string(from: date)
    }
}

// MARK: - Actions
extension SettingViewController {
    @objc func didTapPickerDoneButton() {
        targetWeightRepository.saveTargetWeight(
            weight: WeightPickerView.Constants
            .pickerDataArray[targetWeightPicker.selectedRow]
        )

        personalSettingsSectionView
            .setValueLabel(
                value: String(
                    format: "%.1f",
                    targetWeightRepository.loadTargetWeight()
            )
        )

        textFieldForPicker.resignFirstResponder()
    }

    @objc func didTapTargetWeightButton() {
        textFieldForPicker.becomeFirstResponder()
    }

    @objc func didTapNotificationTimeButton() {
        textFieldForTimePicker.becomeFirstResponder()
    }

    @objc func didTapTimePickerOkButton() {
        notificationTimeRepository.saveTime(time: notificationTimePicker.date)

        let dateString
            = getDateString(date: notificationTimePicker.date)
        notificationSectionView
            .setNotificationTimeLabel(value: dateString)
        textFieldForTimePicker.resignFirstResponder()

        notificationSectionView.setNotification()
    }
}

extension SettingViewController: NotificationSectionViewDelegate {
    func setGrant() {
        notificationSender.grant()
    }

    func getSettings() -> AuthorizationStatus {
        return notificationSender.getSettings()
    }

    func saveNotificationSwitchValue(value: Bool) {
        notificationSwitchStatusRepository.saveData(value: value)
    }

    func sendNotification() {
        notificationSender.sendNotification(time: notificationTimePicker.date)
    }

    func stopNotification() {
        notificationSender.stopNotification()
    }
}
