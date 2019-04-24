import UIKit

class GraphViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)

        title = "グラフ"
        view.backgroundColor = .white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
