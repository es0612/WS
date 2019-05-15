import UIKit
import PureLayout

class InputViewController: TemplateViewController {
    // MARK: - Injected Dependencies
    private let router: Router
    private let weightRepository: WeightRepository

    // MARK: - Views
    private let inputForm: UIStackView
    private let inputTextField: UITextField
    private let kgLabel: UILabel
    private let OkButton: UIButton

    private let weightPickerToolbar: UIToolbar
    private let weightPicker: WeightPickerView

    // MARK: - Initialization
    init(router: Router,
         weightRepository: WeightRepository
        ) {
        self.router = router
        self.weightRepository = weightRepository

        inputForm = UIStackView.newAutoLayout()
        inputTextField = UITextField.newAutoLayout()
        kgLabel = UILabel.newAutoLayout()
        OkButton = UIButton(type: .system)

        weightPickerToolbar = UIToolbar.newAutoLayout()
        weightPicker = WeightPickerView.newAutoLayout()


        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override Methods
    override func configureConstraints() {
        inputForm.autoPinEdgesToSuperviewSafeArea(with: .zero, excludingEdge: .bottom)
    }

    override func viewWillAppear(_ animated: Bool) {
        if let mostRecentWeight = weightRepository.getMostRecentWeight() {
            inputTextField.text
                = String(format: "%.1f", mostRecentWeight)
            weightPicker.selectRowFor(weight: mostRecentWeight)
        }
        else {
            inputTextField.text = "50.0"
            weightPicker.selectRowFor(weight: 50.0)
        }
    }

    override func addSubviews(){
        view.addSubview(inputForm)

        inputForm.addArrangedSubview(inputTextField)
        inputForm.addArrangedSubview(kgLabel)
        inputForm.addArrangedSubview(OkButton)
    }

    override func viewConfigurations() {
        self.title = "入力"

        inputTextField.placeholder = "00.0"
        inputTextField.inputView = weightPicker
        inputTextField.inputAccessoryView = weightPickerToolbar

        kgLabel.text = "kg"
        
        OkButton.setTitle("OK", for: .normal)
        OkButton.addTarget(self, action: #selector(didTapOkButton), for: .touchUpInside)

        inputForm.axis = .vertical

        pickerViewConfiguration()
        pickerToolbarConfiguration()

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "< キャンセル",
            style: .plain,
            target: self,
            action: #selector(didTapCancelButton)
        )
    }

    override func applyStyles() {
        view.backgroundColor = UIColor.background.main

        weightPicker.backgroundColor
            = UIColor.picker.main
        weightPickerToolbar.barTintColor
            = UIColor.picker.bar
    }
}

// MARK: - Private Methods
fileprivate extension InputViewController {
    func pickerViewConfiguration() {
        weightPicker.dataSource = self
        weightPicker.delegate = self
    }

    func pickerToolbarConfiguration() {
        weightPickerToolbar.autoresizingMask = .flexibleHeight
        weightPickerToolbar.barStyle = .default
        weightPickerToolbar.barTintColor = UIColor.lightGray
        weightPickerToolbar.isTranslucent = false

        let flexSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace, target: nil, action: nil
        )

        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(didTapPickerDoneButton)
        )

        doneButton.tintColor = UIColor.white

        weightPickerToolbar.items = [flexSpace, doneButton]
    }
}

// MARK: - Actions
extension InputViewController {
    @objc func didTapOkButton() {
        if let WeightString = inputTextField.text {
            if let inputWeignt = Double(WeightString) {
                weightRepository.saveData(weight: inputWeignt)
                router.dismissInputScreen()
            }
        }
    }

    @objc func didTapPickerDoneButton() {
        let weightString = String(
            format: "%.1f",
            WeightPickerView
                .Constants
                .pickerDataArray[weightPicker.selectedRow]
        )

        inputTextField.text = weightString
        inputTextField.resignFirstResponder()
    }

    @objc func didTapCancelButton() {
        router.dismissInputScreen()
    }
}
