import UIKit

extension UIViewController {
    public func hasLineChartView() -> Bool {
        return view.findLineChartView().isNotNil()
    }
}
