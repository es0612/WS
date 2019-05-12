import UIKit

class SettingViewController: TemplateViewController{
    // MARK: - Injected Dependencies
    private var targetWeightRepository: TargetWeightRepository

    // MARK: - Views
    private let settingStackView: UIStackView

    private let textFieldForPicker: UITextField
    private let targetWeightPicker: WeightPickerView
    private let targetWeightPickerToolbar: UIToolbar

    private let sectionLabel: UILabel
    private let headerButton: UIButton
    private let valueLabel: UILabel

    private let notificationSectionLabel: UILabel
    private let notificationOnOffLabel: UILabel
    private let notificationSwitch: UISwitch
    private let notificationTimeButton: UIButton

    // MARK: - Initialization
    init(targetWeightRepository: TargetWeightRepository) {
        self.targetWeightRepository = targetWeightRepository

        settingStackView = UIStackView.newAutoLayout()

        textFieldForPicker = UITextField.newAutoLayout()
        targetWeightPicker = WeightPickerView.newAutoLayout()
        targetWeightPickerToolbar = UIToolbar.newAutoLayout()

        sectionLabel = UILabel.newAutoLayout()
        headerButton = UIButton(type: .system)
        valueLabel = UILabel.newAutoLayout()

        notificationSectionLabel = UILabel.newAutoLayout()
        notificationOnOffLabel = UILabel.newAutoLayout()
        notificationSwitch = UISwitch.newAutoLayout()
        notificationTimeButton = UIButton(type: .system)

        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override Methods
    override func configureConstraints() {
        settingStackView.autoPinEdgesToSuperviewSafeArea(with: .zero, excludingEdge: .bottom)
    }

    override func viewWillAppear(_ animated: Bool) {
        let targetWeight
            = targetWeightRepository.loadTargetWeight()

        targetWeightPicker
            .selectRowFor(weight: targetWeight)

        valueLabel.text =
            String(format: "%.1f", targetWeight)
    }

    override func addSubviews(){
        view.addSubview(textFieldForPicker)

        view.addSubview(settingStackView)

        settingStackView.addArrangedSubview(sectionLabel)
        settingStackView.addArrangedSubview(headerButton)

        settingStackView.addArrangedSubview(valueLabel)

        settingStackView.addArrangedSubview(notificationSectionLabel)
        settingStackView.addArrangedSubview(notificationOnOffLabel)
        settingStackView.addArrangedSubview(notificationSwitch)
        settingStackView.addArrangedSubview(notificationTimeButton)

        settingStackView.axis = .vertical
    }

    override func viewConfigurations() {
        title = "設定"
        view.backgroundColor = .white

        sectionLabel.text = "個人設定"

        headerButton.setTitle("目標体重", for: .normal)

        headerButton.addTarget(self, action: #selector(didTapTargetWeightButton), for: .touchUpInside)

        notificationSectionLabel.text = "通知"
        notificationOnOffLabel.text = "ON/OFF"
        notificationTimeButton.setTitle("通知時間", for: .normal)


        textFieldForPickerConfiguration()
        pickerViewConfiguration()
        pickerToolbarConfiguration()
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

        valueLabel.text = String(format: "%.1f", targetWeightRepository.loadTargetWeight())
        textFieldForPicker.resignFirstResponder()
    }

    @objc func didTapTargetWeightButton() {
        textFieldForPicker.becomeFirstResponder()
    }
}
