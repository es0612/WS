import UIKit
import Charts

extension UIView {
    public func findLineChartView() -> LineChartView? {
        for subview in subviews {
            if let lineChartView = subview as? LineChartView {
                return lineChartView
            }

            if let lineChartView = subview.findLineChartView() {
                return lineChartView
            }
        }

        return nil
    }
}
