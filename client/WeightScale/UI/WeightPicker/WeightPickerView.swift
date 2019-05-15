import UIKit

class WeightPickerView: UIPickerView {
    // MARK: - Properties
    struct Constants {
        static let pickerDataArray: [Double]
            = (10...1000).map {(Double($0) / 10)}
    }

    private(set) var selectedRow: Int = 0

    // MARK: - Initialization
    init() {
        super.init(frame: CGRect.zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods
    func selectRowFor(weight: Double) {
        for row in 0 ..< Constants.pickerDataArray.count {
            let pickerWeight
                = roundByFirstDecimalPlace(number: Constants.pickerDataArray[row])

            if weight == pickerWeight {
                selectedRow = row
                break
            }
        }

        selectRow(selectedRow, inComponent: 0, animated: false)
    }

    func roundByFirstDecimalPlace(number: Double) -> Double {
        return round(number * 10) / 10
    }

    // MARK: - Override Methods
    override func selectRow(_ row: Int, inComponent component: Int, animated: Bool) {
        super.selectRow(row, inComponent: component, animated: animated)
        selectedRow = row
    }
}
