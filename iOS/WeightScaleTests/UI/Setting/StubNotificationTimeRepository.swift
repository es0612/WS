import Foundation
@testable import WeightScale

class StubNotificationTimeRepository: NotificationTimeRepository {
    private(set) var saveTime_argument_time: Date = Date()
    func saveTime(time: Date) {
        saveTime_argument_time = time
    }
}

