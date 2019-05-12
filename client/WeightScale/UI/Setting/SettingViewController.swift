import UIKit

class SettingViewController: TemplateViewController{
    // MARK: - Injected Dependencies
    private var targetWeightRepository: TargetWeightRepository

    // MARK: - Views
    private let settingTableView: UITableView

    private let textFieldForPicker: UITextField
    private let targetWeightPicker: WeightPickerView
    private let targetWeightPickerToolbar: UIToolbar

    // MARK: - Properties
    private let sections = ["設定", "通知"]
    private let settingSection = ["目標体重"]
    private let notificationSection = ["ON/OFF","通知時間"]

    private var sectionMembers = [[String]]()

    // MARK: - Initialization
    init(targetWeightRepository: TargetWeightRepository) {
        self.targetWeightRepository = targetWeightRepository

        settingTableView = UITableView(frame: .zero, style: .grouped)

        textFieldForPicker = UITextField.newAutoLayout()
        targetWeightPicker = WeightPickerView.newAutoLayout()
        targetWeightPickerToolbar = UIToolbar.newAutoLayout()

        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override Methods
    override func configureConstraints() {
        settingTableView.autoPinEdgesToSuperviewSafeArea()
    }

    override func viewWillAppear(_ animated: Bool) {
        let targetWeight
            = targetWeightRepository.loadTargetWeight()

        targetWeightPicker
            .selectRowFor(weight: targetWeight)
    }

    override func addSubviews(){
        view.addSubview(settingTableView)
        view.addSubview(textFieldForPicker)
    }

    override func viewConfigurations() {
        title = "設定"
        view.backgroundColor = .white

        sectionMembers = [settingSection, notificationSection]

        tableViewConfiguration()

        textFieldForPicker.placeholder = "Target Weight"
        textFieldForPicker.isHidden = true
        textFieldForPicker.inputView = targetWeightPicker
        textFieldForPicker.inputAccessoryView = targetWeightPickerToolbar

        pickerViewConfiguration()
        pickerToolbarConfiguration()
    }
}

// MARK: - Private Methods
private extension SettingViewController {
    func tableViewConfiguration() {
        settingTableView.register(
            SettingTableViewCell.self,
            forCellReuseIdentifier: String(
                describing: SettingTableViewCell.self
            )
        )
        settingTableView.dataSource = self
        settingTableView.delegate = self
    }

    func pickerViewConfiguration() {
        targetWeightPicker.dataSource = self
        targetWeightPicker.delegate = self
    }

    func pickerToolbarConfiguration() {
        targetWeightPickerToolbar.autoresizingMask = .flexibleHeight
        targetWeightPickerToolbar.barStyle = .default
        targetWeightPickerToolbar.barTintColor = UIColor.lightGray
        targetWeightPickerToolbar.isTranslucent = false

        let flexSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace, target: nil, action: nil
        )

        let doneButton = UIBarButtonItem(
            title: "OK",
            style: .done,
            target: self,
            action: #selector(didTapPickerDoneButton)
        )

        doneButton.tintColor = UIColor.white

        targetWeightPickerToolbar.items = [flexSpace, doneButton]
    }
}

// MARK: - Actions
extension SettingViewController {
    @objc func didTapPickerDoneButton() {
        targetWeightRepository.saveTargetWeight(
            weight: WeightPickerView.Constants
            .pickerDataArray[targetWeightPicker.selectedRow]
        )
        settingTableView.reloadData()
        textFieldForPicker.resignFirstResponder()
    }
}


// MARK: - Table View DataSource Methods
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
                cell.detailTextLabel?.text = String(
                    format: "%.1f",
                    targetWeightRepository
                        .loadTargetWeight()
                )
            } else {
                if indexPath.row == 0 {
                    cell.accessoryView = UISwitch(frame: .zero)
                }
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

// MARK: - Table View Delegate Methods
extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            textFieldForPicker.becomeFirstResponder()
        }
    }
}
