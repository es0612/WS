import UIKit

extension UIColor {
    struct background {
        static let main
            = UIColor(red: 0.92, green: 1, blue: 0.95, alpha: 1)
        static let bar
            = UIColor(red: 0.41, green: 0.94, blue: 0.69, alpha: 1)
    }

    struct text {
        static let title
            = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
    }

    struct icon {
        static let selected
            = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        static let normal
            = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1)
    }

    struct graph {
        static let weightLine
            = UIColor(red: 0.61, green: 0.95, blue: 0.85, alpha: 1)
        static let targetWeightLine
            = UIColor(red: 0.97, green: 1, blue: 0.68, alpha: 1)
    }

    struct picker {
        static let bar
            = UIColor(red: 0.66, green: 0.89, blue: 0.75, alpha: 1)
        static let main
            = UIColor(red: 0.75, green: 1, blue: 0.79, alpha: 0.9)
    }

    struct button {
        static let border
            = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        static let shadow
            = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
    }
}
