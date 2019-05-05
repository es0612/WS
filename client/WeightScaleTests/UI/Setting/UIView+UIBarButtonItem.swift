import UIKit

extension UIView {
    func findBarButtonItem(title searchTitle: String) -> UIBarButtonItem? {
        if let toolbar = self as? UIToolbar {
            for barButtonItem in toolbar.items ?? [] {
                if barButtonItem.title == searchTitle {
                    return barButtonItem
                }
            }
        }

        for subview in subviews {
            if let toolbar = subview as? UIToolbar {
                for barButtonItem in toolbar.items ?? [] {
                    if barButtonItem.title == searchTitle {
                        return barButtonItem
                    }
                }
            }

            if let barButtonItem = subview.findBarButtonItem(title: searchTitle) {
                return barButtonItem
            }
        }

        return nil
    }
}
