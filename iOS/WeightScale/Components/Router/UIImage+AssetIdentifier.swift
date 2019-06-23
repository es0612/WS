import UIKit

extension UIImage {
    enum AssetIdentifier: String {
        case listIcon
        case graphIcon
        case settingIcon
        case inputIcon
    }

    convenience init(assetIdentifier: AssetIdentifier) {
        self.init(named: assetIdentifier.rawValue)!
    }
}
