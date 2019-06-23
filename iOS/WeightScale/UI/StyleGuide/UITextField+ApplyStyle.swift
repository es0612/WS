import UIKit

extension UITextField {
    func applyStyle(_ style: UITextFieldStyle) {
        style.apply(to: self)
    }
}


enum UITextFieldStyle {
    case input

    func apply(to textField: UITextField) {
        switch self {
        case .input:
            textField.font = UIFont.textField
            textField.textColor = UIColor.text.inputField
        }
    }
}
