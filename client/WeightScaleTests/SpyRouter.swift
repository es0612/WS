import UIKit
@testable import WeightScale

class SpyRouter: Router {
    var rootViewController: UIViewController?

    private(set) var showInputScreen_wasCalled = false
    func showInputScreen() {
        showInputScreen_wasCalled = true
    }
    
    private(set) var showListScreen_wasCalled = false
    func showListScreen() {
        showListScreen_wasCalled = true
    }
}
