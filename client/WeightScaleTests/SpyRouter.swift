import UIKit
@testable import WeightScale

class SpyRouter: Router {
    var rootViewController: UIViewController?

    private(set) var showInputScreen_wasCalled = false
    func showInputScreen() {
        showInputScreen_wasCalled = true
    }
    
    private(set) var showMainTabBarScreen_wasCalled = false
    func showMainTabBarScreen() {
        showMainTabBarScreen_wasCalled = true
    }
}
