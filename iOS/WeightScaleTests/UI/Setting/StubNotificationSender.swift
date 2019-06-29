@testable import WeightScale

class StubNotificationSender: NotificationSender{
    private(set) var grant_wasCalled = false
    func grant() {
        grant_wasCalled = true
    }

    private(set) var getStettings_wasCalled = false
    var getSettings_returnValue: AuthorizationStatus
        = .unknown
    func getSettings() -> AuthorizationStatus {
        getStettings_wasCalled = true
        return getSettings_returnValue
    }

    private(set) var sendNotification_wasCalled = false
    func sendNotification() {
        sendNotification_wasCalled = true
    }
}
