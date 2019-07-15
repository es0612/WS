import Nimble
import Quick
import Foundation

@testable import WeightScale

class LocalNotificationTimeRepositorySpec: QuickSpec {
    override func spec() {
        describe("Local Notification time Repository に関するテスト") {
            it("通知時間を保存する") {
                let stubUserDefaultsWrapper = StubUserDefaultsWrapper()
                let notificationTimeRepository
                    = LocalNotificationTimeRepository(
                        userDefaultsWrapper: stubUserDefaultsWrapper
                )


                let date = Date()
                notificationTimeRepository.saveTime(time: date)

                
                expect(stubUserDefaultsWrapper.saveDataDate_argument_key)
                    .to(equal("notification_time"))
                expect(stubUserDefaultsWrapper.saveDataDate_argument_value)
                    .to(equal(date))
            }

            it("保存した通知時間を取得する") {
                let stubUserDefaultsWrapper = StubUserDefaultsWrapper()
                let notificationTimeRepository
                    = LocalNotificationTimeRepository(
                        userDefaultsWrapper: stubUserDefaultsWrapper
                )

                stubUserDefaultsWrapper.loadDataDate_returnValue
                    = DateManager.convertStringToTime(string: "17:00")


                let actualTime = notificationTimeRepository.loadTime()


                expect(stubUserDefaultsWrapper.loadDataDate_argument_key)
                    .to(equal("notification_time"))
                expect(DateManager.convertTimeToString(time: actualTime!))
                    .to(equal("17:00"))
            }
        }
    }
}
