import UIKit
@testable import WeightScale

class SpyRouter: Router {
    var rootViewController: UIViewController?

    func setup() {
        
    }

    private(set) var showListViewController_wasCalled = false
    func showListScreen() {
        showListViewController_wasCalled = true
    }
}
