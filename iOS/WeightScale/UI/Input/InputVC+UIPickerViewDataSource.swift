import UIKit

// MARK: - Picker View DataSource Methods
extension InputViewController: UIPickerViewDataSource {
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
            return String(format: "%.1f", WeightPickerView.Constants.pickerDataArray[row])
    }
}
