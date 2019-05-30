import UserNotifications

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
                    print("通知許可")

                    self.setDelegate()
                    return
                }

                print("通知拒否")
            }
        )
    }
}


extension LocalNotificationSender: UNUserNotificationCenterDelegate {
    func setDelegate() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
    }
}
