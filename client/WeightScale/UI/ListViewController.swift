import  UIKit

class ListViewController: UIViewController {
    private var weightRepository: WeightRepository?

    init(weightRepository: WeightRepository? = nil) {
        self.weightRepository = weightRepository

        super.init(nibName: nil, bundle: nil)
        self.title = "リスト"
        self.view.backgroundColor = .white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        weightRepository?.loadData()
    }
    
}
