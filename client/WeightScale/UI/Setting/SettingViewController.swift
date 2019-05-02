import UIKit

class SettingViewController: TemplateViewController{
    // MARK: - Views
    private let settingTableView: UITableView

    // MARK: - Initialization
    override init() {
        settingTableView = UITableView.newAutoLayout()

        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func configureConstraints() {
        settingTableView.autoPinEdgesToSuperviewSafeArea()
    }

    override func addSubviews(){
        view.addSubview(settingTableView)

    }

    override func viewConfigurations() {
        title = "設定"
        view.backgroundColor = .white

        tableViewConfiguration()
    }
}

extension SettingViewController {
    func tableViewConfiguration() {
        settingTableView.register(
            SettingTableViewCell.self,
            forCellReuseIdentifier: String(
                describing: SettingTableViewCell.self
            )
        )
        settingTableView.dataSource = self
        settingTableView.delegate = self


        updateViewConstraints()
    }
}
extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: SettingTableViewCell.self),
            for: indexPath
            ) as! SettingTableViewCell

        cell.backgroundColor = UIColor.white
        cell.textLabel?.text = "目標体重"

        return cell
    }
}

extension SettingViewController: UITableViewDelegate {}
