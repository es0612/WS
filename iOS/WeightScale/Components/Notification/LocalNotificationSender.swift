import UserNotifications

enum AuthorizationStatus: Int {
    case notDetermined
    case denied
    case authorized
    case unknown

    var isEnabled: Bool {
        get {
            switch self {
            case .notDetermined, .authorized:
                return true
            case .unknown, .denied:
                return false
            }
        }
    }
}

protocol NotificationSender {
    func grant()
    func getSettings() -> AuthorizationStatus
    func sendNotification(time: Date)
    func stopNotification()
}

class LocalNotificationSender: NSObject, NotificationSender {
    func grant() {
        let center = UNUserNotificationCenter.current()

        center.requestAuthorization(
            options: [.badge, .sound, .alert],
            completionHandler: { granted, error in
                if error != nil {
                    return
                }

                if granted {
                    self.setDelegate()
                    return
                }
            }
        )
    }

    func getSettings() -> AuthorizationStatus {
        let center = UNUserNotificationCenter.current()
        var status: AuthorizationStatus!
        center.getNotificationSettings()
            { notificationSettings in
                status = AuthorizationStatus
                    .init(
                        rawValue: notificationSettings
                            .authorizationStatus
                            .rawValue)!
        }
//        return status
        return .authorized
    }

    func sendNotification(time: Date) {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: time)
        let minute = calendar.component(.minute, from: time)

        var notificationTime = DateComponents()
        notificationTime.hour = hour
        notificationTime.minute = minute
        let trigger = UNCalendarNotificationTrigger(dateMatching: notificationTime, repeats: true)

        let content = UNMutableNotificationContent()
        content.title = "リマインダー"
        content.body = "今日の体重を入力しましょう"
        content.sound = UNNotificationSound.default


        let request = UNNotificationRequest(
            identifier: "uuid", content: content, trigger: trigger
        )

        let center = UNUserNotificationCenter.current()
        center.add(request, withCompletionHandler: nil)
    }

    func stopNotification() {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
    }
}


extension LocalNotificationSender: UNUserNotificationCenterDelegate {
    func setDelegate() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
    }
}
