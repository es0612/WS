import UIKit

class SettingViewController: UIViewController{
    init() {
        super.init(nibName: nil, bundle: nil)

        title = "設定"
        view.backgroundColor = .white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
