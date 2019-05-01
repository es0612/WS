import UIKit
import PureLayout

protocol WeightRepository {
    func saveData(weight: Double)
    func loadData() -> [WeightData]
}

class InputViewController: UIViewController {
    // MARK: - Injected Dependencies
    private let router: Router
    private let weightRepository: WeightRepository

    // MARK: - Views
    private let inputForm: UIStackView
    private let OkButton: UIButton
    private let inputTextField: UITextField
    private let kgLabel: UILabel

    private let weightPicker: UIPickerView
    private let weightPickerToolbar: UIToolbar

    // MARK: - Properties
    private var didSetupConstraints: Bool = false
    private let pickerDataArray:[Double] = (10...1000).map {(Double($0) * 0.1)}

    // MARK: - Initialization
    init(router: Router,
         weightRepository: WeightRepository
        ) {
        self.router = router
        self.weightRepository = weightRepository

        inputForm = UIStackView.newAutoLayout()
        OkButton = UIButton(type: .system)
        inputTextField = UITextField.newAutoLayout()
        kgLabel = UILabel.newAutoLayout()

        weightPicker = UIPickerView.newAutoLayout()
        weightPickerToolbar = UIToolbar.newAutoLayout()


        super.init(nibName: nil, bundle: nil)


        addSubviews()
        viewConfigurations()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateViewConstraints() {
        if didSetupConstraints == false {
            inputForm.autoPinEdgesToSuperviewSafeArea(with: .zero, excludingEdge: .bottom)

            didSetupConstraints = true
        }
        super.updateViewConstraints()
    }

    func addSubviews(){
        view.addSubview(inputForm)

        inputForm.addArrangedSubview(inputTextField)
        inputForm.addArrangedSubview(kgLabel)
        inputForm.addArrangedSubview(OkButton)

    }

    func viewConfigurations() {
        OkButton.setTitle("OK", for: .normal)
        OkButton.addTarget(self, action: #selector(didTapOkButton), for: .touchUpInside)

        inputTextField.placeholder = "00.0"
        inputTextField.inputView = weightPicker

        kgLabel.text = "kg"

        inputForm.axis = .vertical

        view.backgroundColor = .white

        weightPicker.dataSource = self
        weightPicker.delegate = self
        weightPicker.selectRow(490, inComponent: 0, animated: true)

        weightPickerToolbar.autoresizingMask = .flexibleHeight
        weightPickerToolbar.barStyle = .default
        weightPickerToolbar.barTintColor = UIColor.lightGray
        weightPickerToolbar.isTranslucent = false

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(didTapPickerDoneButton)
        )

        doneButton.tintColor = UIColor.white

        weightPickerToolbar.items = [flexSpace, doneButton]

        inputTextField.inputAccessoryView = weightPickerToolbar
    }

    @objc func didTapOkButton() {
        if let WeightString = inputTextField.text {
            if let inputWeignt = Double(WeightString) {
                weightRepository.saveData(weight: inputWeignt)
                router.showMainTabBarScreen()
            }
        }
    }

    @objc func didTapPickerDoneButton() {
        inputTextField.resignFirstResponder()
    }
}

extension InputViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataArray.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(format: "%.1f", pickerDataArray[row])
    }
}

extension InputViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        inputTextField.text = String(format: "%.1f", pickerDataArray[row])
    }
}
