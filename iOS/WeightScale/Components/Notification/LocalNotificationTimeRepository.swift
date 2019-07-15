import Foundation

protocol NotificationTimeRepository {
    func saveTime(time: Date)
}

class LocalNotificationTimeRepository: NotificationTimeRepository {
    private var userDefaultsWrapper: UserDefaultsWrapper

    init(userDefaultsWrapper: UserDefaultsWrapper) {
        self.userDefaultsWrapper = userDefaultsWrapper
    }

    func saveTime(time: Date) {
        userDefaultsWrapper.saveData(key: "notification_time", value: time)
    }
}
