@testable import WeightScale
import Foundation

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
    private(set) var sendNotification_argument_time = Date()
    func sendNotification(time: Date) {
        sendNotification_wasCalled = true
        sendNotification_argument_time = time
    }

    private(set) var stopNotification_wasCalled = false
    func stopNotification() {
        stopNotification_wasCalled = true
    }
}
