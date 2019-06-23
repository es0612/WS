import UIKit

class TemplateViewController: UIViewController {
    // MARK: - Properties
    private var didSetupConstraints: Bool = false

    // MARK: - Initialization
    init() {
        super.init(nibName: nil, bundle: nil)

        view.setNeedsUpdateConstraints()

        addSubviews()
        viewConfigurations()
        applyStyles()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override Methods
    override func updateViewConstraints() {
        if didSetupConstraints == false {
            configureConstraints()

            didSetupConstraints = true
        }
        super.updateViewConstraints()
    }

    func configureConstraints() {
    }

    func addSubviews() {
    }

    func viewConfigurations() {
    }

    func applyStyles() {
    }
}
