@testable import WeightScale

class StubNotificationSender: NotificationSender{
    private(set) var grant_wasCalled = false
    func grant() {
        grant_wasCalled = true
    }
}
