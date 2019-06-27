protocol NotificationSwitchStatusRepository {
    func saveData(value: Bool)
    func loadData() -> Bool
}

class LocalNotificationSwitchValueRepository :NotificationSwitchStatusRepository {
    private var userDefaultsWrapper: UserDefaultsWrapper

    init(userDefaultsWrapper: UserDefaultsWrapper) {
        self.userDefaultsWrapper = userDefaultsWrapper
    }
    
    func saveData(value: Bool) {
        userDefaultsWrapper.saveData(key: "notification_switch", value: value)
    }

    func loadData() -> Bool {
        return userDefaultsWrapper.loadData(key: "notification_switch")
    }
}
