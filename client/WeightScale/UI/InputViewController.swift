import UIKit
import PureLayout

protocol WeightRepository {
    func saveData(weight: Double)
    func loadData() -> [WeightData]
}

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
    private let weightPicker: UIPickerView


    // MARK: - Properties
    private let pickerDataArray:[Double]
        = (10...1000).map {(Double($0) * 0.1)}

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
        weightPicker = UIPickerView.newAutoLayout()


        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override Methods
    override func configureConstraints() {
        inputForm.autoPinEdgesToSuperviewSafeArea(with: .zero, excludingEdge: .bottom)
    }

    override func viewDidLoad() {
        inputTextField.text = "50.0"
    }

    override func addSubviews(){
        view.addSubview(inputForm)

        inputForm.addArrangedSubview(inputTextField)
        inputForm.addArrangedSubview(kgLabel)
        inputForm.addArrangedSubview(OkButton)
    }

    override func viewConfigurations() {
        inputTextField.placeholder = "00.0"
        inputTextField.inputView = weightPicker

        kgLabel.text = "kg"
        
        OkButton.setTitle("OK", for: .normal)
        OkButton.addTarget(self, action: #selector(didTapOkButton), for: .touchUpInside)

        inputForm.axis = .vertical

        view.backgroundColor = .white

        pickerViewConfiguration()
        pickerToolbarConfiguration()
    }
}

// MARK: - Private Methods
fileprivate extension InputViewController {
    func pickerViewConfiguration() {
        weightPicker.dataSource = self
        weightPicker.delegate = self
        weightPicker.selectRow(490, inComponent: 0, animated: true)
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

        inputTextField.inputAccessoryView = weightPickerToolbar
    }
}

// MARK: - Actions
extension InputViewController {
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

// MARK: - Picker View DataSource Methods
extension InputViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView)
        -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int)
        -> Int {
        return pickerDataArray.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int)
        -> String? {
        return String(format: "%.1f", pickerDataArray[row])
    }
}

// MARK: - Picker View Delegate Methods
extension InputViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        inputTextField.text = String(format: "%.1f", pickerDataArray[row])
    }
}
