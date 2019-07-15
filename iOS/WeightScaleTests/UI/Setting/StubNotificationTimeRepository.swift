import Foundation
@testable import WeightScale

class StubNotificationTimeRepository: NotificationTimeRepository {
    private(set) var saveTime_argument_time: Date = Date()
    func saveTime(time: Date) {
        saveTime_argument_time = time
    }

    private(set) var loadTime_wasCalled = false
    var loadTime_returnValue: Date? = nil
    func loadTime() -> Date? {
        loadTime_wasCalled = true
        return loadTime_returnValue
    }
}

