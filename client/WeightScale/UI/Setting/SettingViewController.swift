import UIKit

class SettingViewController: TemplateViewController{
    // MARK: - Views
    private let settingTableView: UITableView

    // MARK: - Properties
    private let sections = ["設定", "通知"]
    private let settingSection = ["目標体重"]
    private let notificationSection = ["ON/OFF","通知時間"]

    private var sectionMembers = [[String]]()


    // MARK: - Initialization
    override init() {
        settingTableView = UITableView(frame: .zero, style: .grouped)
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

        sectionMembers = [settingSection, notificationSection]

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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int {
            return sectionMembers[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: SettingTableViewCell.self),
                for: indexPath
                ) as! SettingTableViewCell

            cell.textLabel?.text = sectionMembers[indexPath.section][indexPath.row]

            if indexPath.section == 0 {
                cell.detailTextLabel?.text = "50.0"
            }

            return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int)
        -> UIView? {
            let sectionLabel = UILabel()
            sectionLabel.text = sections[section]
            sectionLabel.backgroundColor = .clear

            return sectionLabel
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
