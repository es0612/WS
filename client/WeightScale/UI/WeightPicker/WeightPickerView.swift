import UIKit

class WeightPickerView: UIPickerView {
    // MARK: - Properties
    struct Constants {
        static let pickerDataArray: [Double]
            = (10...1000).map {(Double($0) * 0.1)}
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
            if weight == Constants.pickerDataArray[row] {
                selectedRow = row
                break
            }
        }

        selectRow(selectedRow, inComponent: 0, animated: false)
    }

    // MARK: - Override Methods
    override func selectRow(_ row: Int, inComponent component: Int, animated: Bool) {
        super.selectRow(row, inComponent: component, animated: animated)
        selectedRow = row
    }
}
