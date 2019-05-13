import UIKit

class TemplateView: UIView {
    // MARK: - Properties
    private var didSetupConstraints: Bool = false
    private var didFinishLayoutSubviews: Bool = false

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)

        translatesAutoresizingMaskIntoConstraints
            = false

        addSubviews()
        viewConfigurations()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override Methods
    override func updateConstraints() {
        if didSetupConstraints == false {
            configureConstraints()

            didSetupConstraints = true
        }

        super.updateConstraints()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if didFinishLayoutSubviews == false {
            didLayoutSubviews()

            didFinishLayoutSubviews = true
        }
    }

    func configureConstraints() {
    }

    func didLayoutSubviews() {
    }

    func addSubviews() {
    }

    func viewConfigurations() {
    }
}
