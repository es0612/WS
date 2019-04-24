import UIKit
import PureLayout

class InputViewController: UIViewController {
    // MARK: - Initialization
    private let router: Router

    // MARK: - Views
    private let inputForm: UIStackView
    private let OkButton: UIButton
    private let inputTextField: UITextField
    private let kgLabel: UILabel

    // MARK: - Properties
    private var didSetupConstraints: Bool = false

    // MARK: - Initialization
    init(router: Router) {
        self.router = router

        inputForm = UIStackView.newAutoLayout()
        OkButton = UIButton(type: .system)
        inputTextField = UITextField.newAutoLayout()
        kgLabel = UILabel.newAutoLayout()

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

        inputForm.addArrangedSubview(OkButton)
        inputForm.addArrangedSubview(inputTextField)
        inputForm.addArrangedSubview(kgLabel)

    }

    func viewConfigurations() {
        OkButton.setTitle("OK", for: .normal)
        OkButton.addTarget(self, action: #selector(didTapOkButton), for: .touchUpInside)

        inputTextField.placeholder = "00.0"
        inputTextField.keyboardType = .numberPad

        kgLabel.text = "kg"

        inputForm.axis = .vertical

        view.backgroundColor = .white
    }

    @objc func didTapOkButton() {
        router.showMainTabBarScreen()
    }
}
