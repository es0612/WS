import  UIKit

class ListViewController: UIViewController {
    // MARK: - Injected Dependencies
    private var weightRepository: WeightRepository

    // MARK: - Views
    private let weightListTableView: UITableView

    // MARK: - Properties
    private var didSetupConstraints: Bool = false
    private var weightDataList: [WeightData] = []

    // MARK: - Initialization
    init(weightRepository: WeightRepository) {
        self.weightRepository = weightRepository

        weightListTableView = UITableView.newAutoLayout()


        super.init(nibName: nil, bundle: nil)


        addSubviews()
        viewConfigurations()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateViewConstraints() {
        if didSetupConstraints == false {
            weightListTableView.autoPinEdgesToSuperviewSafeArea()

            didSetupConstraints = true
        }
        super.updateViewConstraints()
    }

    override func viewDidLoad() {
        weightDataList = weightRepository.loadData()
    }

    func addSubviews(){
        view.addSubview(weightListTableView)
    }

    func viewConfigurations() {
        title = "リスト"
        view.backgroundColor = .white

        weightListTableView.register(WeightListTableViewCell.self, forCellReuseIdentifier: String(describing: WeightListTableViewCell.self))

        weightListTableView.dataSource = self
        weightListTableView.delegate = self
    }
}


extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int)
        -> Int {

        return weightDataList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: WeightListTableViewCell.self),
            for: indexPath
            ) as! WeightListTableViewCell

        cell.backgroundColor = UIColor.white
        cell.textLabel?.text = weightDataList[indexPath.row].dateString
        cell.detailTextLabel?.text = String(weightDataList[indexPath.row].weight)

        return cell
    }
}

extension ListViewController: UITableViewDelegate {
}

class WeightListTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1,
                   reuseIdentifier: reuseIdentifier
        )
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
