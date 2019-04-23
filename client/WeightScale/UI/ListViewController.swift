import  UIKit

class ListViewController: UIViewController {
    init() {

        super.init(nibName: nil, bundle: nil)
        self.title = "リスト"
        self.view.backgroundColor = .white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
