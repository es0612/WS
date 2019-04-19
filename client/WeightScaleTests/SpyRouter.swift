@testable import WeightScale

class SpyRouter: Router {
    private(set) var showListViewController_wasCalled = false
    func showListViewController() {
        showListViewController_wasCalled = true
    }
}
