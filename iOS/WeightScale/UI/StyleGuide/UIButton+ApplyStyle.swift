import UIKit

extension UIButton {
    func applyStyle(_ style:UIButtonStyle) {
        style.apply(to: self)
    }
}

enum UIButtonStyle {
    case normal

    func apply(to button: UIButton) {
        switch self {
        case .normal:
            button.setTitleColor(UIColor.text.title, for: .normal)
            button.titleLabel?.font = UIFont.title

            button.backgroundColor = UIColor.background.bar
            button.layer.borderColor = UIColor.button.border.cgColor
            button.applyShadow()

        }
    }
}

extension UIButton {
    func applyShadow() {
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 4.0
        layer.shadowOffset
            = CGSize(width: 0, height: 1)
        layer.shadowColor
            = UIColor.button.shadow.cgColor
    }
}
