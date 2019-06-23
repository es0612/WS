import UIKit

// MARK: - Picker View Delegate Methods
extension SettingViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.selectRow(row, inComponent: component, animated: false)
    }
}
