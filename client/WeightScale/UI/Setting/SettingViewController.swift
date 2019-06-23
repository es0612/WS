import UIKit

protocol NotificationSwitchStatusRepository {
    func saveData(value: Bool)
    func loadData() -> Bool
}

class SettingViewController: TemplateViewController{
    // MARK: - Injected Dependencies
    private var targetWeightRepository: TargetWeightRepository
    private var notificationSender: NotificationSender
    private var notificationSwitchStatusRepository: NotificationSwitchStatusRepository?

    // MARK: - Views
    private let settingStackView: UIStackView

    private let textFieldForPicker: UITextField
    private let targetWeightPicker: WeightPickerView
    private let targetWeightPickerToolbar: UIToolbar

    private let personalSettingsSectionView: PersonalSettingsSectionView
    private let notificationSectionView: NotificationSectionView

    // MARK: - Initialization
    init(targetWeightRepository: TargetWeightRepository,
         notificationSender: NotificationSender,
         notificationSwitchStatusRepository: NotificationSwitchStatusRepository? = nil) {
        self.targetWeightRepository = targetWeightRepository
        self.notificationSender = notificationSender
        self.notificationSwitchStatusRepository = notificationSwitchStatusRepository

        settingStackView = UIStackView.newAutoLayout()

        textFieldForPicker = UITextField.newAutoLayout()
        targetWeightPicker = WeightPickerView.newAutoLayout()
        targetWeightPickerToolbar = UIToolbar.newAutoLayout()

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
    }

    override func addSubviews(){
        view.addSubview(textFieldForPicker)
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
    }

    override func applyStyles() {
        view.backgroundColor = UIColor.background.main

        targetWeightPicker.backgroundColor
            = UIColor.picker.main
        targetWeightPickerToolbar.barTintColor
            = UIColor.picker.bar
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
        targetWeightPickerToolbar.barTintColor = UIColor.lightGray
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
}

extension SettingViewController: NotificationSectionViewDelegate {
    func setGrant() {
        notificationSender.grant()
    }

    func getSettings() -> AuthorizationStatus {
        return notificationSender.getSettings()
    }

    func setNotificationSwitchValue(value: Bool) {
        notificationSwitchStatusRepository?.saveData(value: value)
    }
}
