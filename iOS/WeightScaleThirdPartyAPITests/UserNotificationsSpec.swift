import Nimble
import Quick

import UserNotifications

class UserNotificationsSpec: QuickSpec {

    override func spec() {
        describe("UserNotificationsに関するテスト") {
            it("通知登録した後に削除することで、10秒で通知が送られないことを確認"){
                self.notificationGrant()
                self.notificationSender()
            }
        }
    }
}

extension UserNotificationsSpec: UNUserNotificationCenterDelegate {
    func notificationGrant() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(
            options: [.badge, .sound, .alert],
            completionHandler: { granted, error in

                if error != nil {
                    return
                }

                if granted {
                    print("通知許可")

                    let center = UNUserNotificationCenter.current()
                    center.delegate = self

                } else {
                    print("通知拒否")
                }
        })
    }

    func notificationSender() {
        //        var notificationTime = DateComponents()
        //        notificationTime.hour = 12
        //        notificationTime.minute = 0
        //        let trigger = UNCalendarNotificationTrigger(dateMatching: notificationTime, repeats: true)

        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 10, repeats: false
        )


        let content = UNMutableNotificationContent()
        content.title = "リマインダー"
        content.body = "今日の体重を入力しましょう"
        content.sound = UNNotificationSound.default


        let request = UNNotificationRequest(
            identifier: "uuid", content: content, trigger: trigger
        )
        UNUserNotificationCenter.current()
            .add(request, withCompletionHandler: nil)


        UNUserNotificationCenter.current()
            .removeAllPendingNotificationRequests()
    }
}
