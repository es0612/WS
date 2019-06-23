import  UIKit

class ListViewController: TemplateViewController {
    // MARK: - Injected Dependencies
    private var weightRepository: WeightRepository
    private var router: Router

    // MARK: - Views
    private let weightListTableView: UITableView

    // MARK: - Properties
    private var weightDataList: [WeightData] = []

    // MARK: - Initialization
    init(weightRepository: WeightRepository, router: Router) {
        self.weightRepository = weightRepository
        self.router = router

        weightListTableView = UITableView.newAutoLayout()

        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override Methods
    override func configureConstraints() {
        weightListTableView.autoPinEdgesToSuperviewSafeArea()
    }

    override func viewWillAppear(_ animated: Bool) {
        weightDataList = weightRepository.loadData()
        weightDataList.reverse()

        weightListTableView.reloadData()

        if !weightRepository.checkInputOfToday() {
            router.showInputScreen()
        }
    }

    override func addSubviews(){
        view.addSubview(weightListTableView)
    }

    override func viewConfigurations() {
        title = "記録"
        view.backgroundColor = .white

        tableViewConfiguration()

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(assetIdentifier: .inputIcon),
            style: .plain,
            target: self,
            action: #selector(didTapInputButton)
        )
    }

    override func applyStyles() {
        view.backgroundColor = UIColor.background.main

        weightListTableView.backgroundColor = UIColor.background.main
        
        navigationItem.rightBarButtonItem?.tintColor = UIColor.icon.selected
    }
}

// MARK: - Public Methods
extension ListViewController {
    @objc func didTapInputButton() {
        router.showInputScreen()
    }
}

// MARK: - Private Methods
private extension ListViewController {
    func tableViewConfiguration() {
        weightListTableView.register(
            WeightListTableViewCell.self,
            forCellReuseIdentifier: String(describing: WeightListTableViewCell.self)
        )

        weightListTableView.dataSource = self
        weightListTableView.delegate = self
    }
}

// MARK: - Table View DataSource Methods
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int)
        -> Int {

            return weightDataList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: WeightListTableViewCell.self),
                for: indexPath
                ) as! WeightListTableViewCell

            cell.textLabel?.text = weightDataList[indexPath.row].dateString
            cell.detailTextLabel?.text = String(weightDataList[indexPath.row].weight)
                + " kg"

            if cell.textLabel?.text == DateManager.getToday() {
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            }

            return cell
    }
}

// MARK: - Table View Delegate Methods
extension ListViewController: UITableViewDelegate {}
