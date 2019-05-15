import UIKit

extension UILabel {
    func applyStyle(_ style: UILabelStyle) {
        style.apply(to: self)
    }
}


enum UILabelStyle {
    case forInput

    func apply(to label: UILabel) {
        switch self {
        case .forInput:
            label.font = UIFont.title
            label.textColor = UIColor.text.kg
        }
    }
}
