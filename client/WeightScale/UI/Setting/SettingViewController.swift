import UIKit

class SettingViewController: TemplateViewController{
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
    override init() {
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


        updateViewConstraints()
    }

    func pickerViewConfiguration() {
        targetWeightPicker.dataSource = self
        targetWeightPicker.delegate = self
        targetWeightPicker.selectRowFor(weight: 50.0)
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
                    WeightPickerView.Constants
                        .pickerDataArray[targetWeightPicker.selectedRow]
                )
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

// MARK: - Picker View DataSource Methods
extension SettingViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView)
        -> Int {
            return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int)
        -> Int {
            return WeightPickerView.Constants.pickerDataArray.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int)
        -> String? {
            return String(
                format: "%.1f",
                WeightPickerView.Constants.pickerDataArray[row]
            )
    }
}

// MARK: - Picker View Delegate Methods
extension SettingViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.selectRow(row, inComponent: component, animated: false)
    }
}

class WeightPickerView: UIPickerView {
    // MARK: - Properties
    struct Constants {
        static let pickerDataArray: [Double]
            = (10...1000).map {(Double($0) * 0.1)}
    }

    private(set) var selectedRow: Int = 0

    // MARK: - Public Methods
    func selectRowFor(weight: Double) {
        for row in 0 ..< Constants.pickerDataArray.count {
            if weight == Constants.pickerDataArray[row] {
                selectedRow = row
                break
            }
        }

        selectRow(selectedRow, inComponent: 0, animated: false)
    }

    override func selectRow(_ row: Int, inComponent component: Int, animated: Bool) {
        super.selectRow(row, inComponent: component, animated: animated)
        selectedRow = row
    }
}
