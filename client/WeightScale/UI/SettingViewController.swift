import UIKit

class SettingViewController: UIViewController{
    // MARK: - Views
    private let settingStackView: UIStackView
    private let targetWeightLabel: UILabel

    // MARK: - Properties
    private var didSetupConstraints: Bool = false

    init() {
        settingStackView = UIStackView.newAutoLayout()
        targetWeightLabel = UILabel.newAutoLayout()

        super.init(nibName: nil, bundle: nil)

        addSubviews()
        viewConfigurations()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateViewConstraints() {
        if didSetupConstraints == false {
            settingStackView.autoPinEdgesToSuperviewEdges()

            didSetupConstraints = true
        }
        super.updateViewConstraints()
    }

    func addSubviews(){
        view.addSubview(settingStackView)

        settingStackView.addArrangedSubview(targetWeightLabel)
    }

    func viewConfigurations() {
        title = "設定"
        view.backgroundColor = .white

        settingStackView.axis = .vertical

        targetWeightLabel.text = "目標体重"
    }
}
