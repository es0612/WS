import UIKit
import PureLayout

class InputViewController: UIViewController {
    // MARK: - Views
    private let inputForm: UIStackView
    private let OkButton: UIButton
    private let inputTextField: UITextField
    private let kgLabel: UILabel

    // MARK: - Properties
    private var didSetupConstraints: Bool = false

    // MARK: - Initialization
    init() {
        inputForm = UIStackView.newAutoLayout()
        OkButton = UIButton(type: .system)
        inputTextField = UITextField.newAutoLayout()
        kgLabel = UILabel.newAutoLayout()


        super.init(nibName: nil, bundle: nil)


        view.addSubview(inputForm)

        OkButton.setTitle("OK", for: .normal)
        inputForm.addArrangedSubview(OkButton)

        inputTextField.placeholder = "00.0"
        inputForm.addArrangedSubview(inputTextField)

        kgLabel.text = "kg"
        inputForm.addArrangedSubview(kgLabel)

        inputForm.axis = .vertical
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
}
