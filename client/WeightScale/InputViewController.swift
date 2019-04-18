import UIKit
import PureLayout

class InputViewController: UIViewController {
    // MARK: - Views
    private var inputForm = UIStackView.newAutoLayout()
    private let OkButton: UIButton

    // MARK: - Properties
    private var didSetupConstraints: Bool = false

    // MARK: - Initialization
    init() {
        inputForm = UIStackView.newAutoLayout()
        OkButton = UIButton(type: .system)


        super.init(nibName: nil, bundle: nil)

        
        view.addSubview(inputForm)

        OkButton.setTitle("OK", for: .normal)
        inputForm.addArrangedSubview(OkButton)

        inputForm.axis = .horizontal
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
