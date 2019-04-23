import UIKit
@testable import WeightScale

class SpyRouter: Router {
    var rootViewController: UIViewController?

    private(set) var setup_wasCalled = false
    func setup() {
        setup_wasCalled = true
    }

    private(set) var showListViewController_wasCalled = false
    func showListScreen() {
        showListViewController_wasCalled = true
    }
}
