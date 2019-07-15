import Foundation

protocol NotificationTimeRepository {
    func saveTime(time: Date)
    func loadTime() -> Date?
}

class LocalNotificationTimeRepository: NotificationTimeRepository {
    private var userDefaultsWrapper: UserDefaultsWrapper

    init(userDefaultsWrapper: UserDefaultsWrapper) {
        self.userDefaultsWrapper = userDefaultsWrapper
    }

    func saveTime(time: Date) {
        userDefaultsWrapper.saveData(key: "notification_time", value: time)
    }

    func loadTime() -> Date? {
        return userDefaultsWrapper.loadData(key: "notification_time")
    }
}
