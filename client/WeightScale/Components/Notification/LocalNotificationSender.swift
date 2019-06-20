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
//        let center = UNUserNotificationCenter.current()
//        var status: AuthorizationStatus!
//        center.getNotificationSettings()
//            { notificationSettings in
//                status = AuthorizationStatus
//                    .init(
//                        rawValue: notificationSettings
//                            .authorizationStatus
//                            .rawValue)!
//        }
//        return status
        return .unknown
    }
}


extension LocalNotificationSender: UNUserNotificationCenterDelegate {
    func setDelegate() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
    }
}
