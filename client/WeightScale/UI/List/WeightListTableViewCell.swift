import UIKit

class WeightListTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1,
                   reuseIdentifier: reuseIdentifier
        )

        applyStyles()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func applyStyles() {
        self.selectionStyle = .default
        let selectedView = UIView()
        selectedView.backgroundColor
            = UIColor.background.main
        self.selectedBackgroundView =  selectedView
    }
}
