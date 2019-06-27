import Nimble
import Quick

@testable import WeightScale

class LocalNotificationSwitchValueRepositorySpec: QuickSpec {
    override func spec() {
        describe("Local Notification SwitchValue Repository に関するテスト") {
            it("スイッチの状態を保存する") {
                let stubUserDefaultsWrapper = StubUserDefaultsWrapper()
                let notificationSwitchValueRepository = LocalNotificationSwitchValueRepository(
                    userDefaultsWrapper: stubUserDefaultsWrapper
                )


                notificationSwitchValueRepository.saveData(value: true)


                expect(stubUserDefaultsWrapper.saveDataBool_argument_key)
                    .to(equal("notification_switch"))
                expect(stubUserDefaultsWrapper.saveDataBool_argument_value)
                    .to(equal(true))
            }

            it("保存したスイッチの状態を取得する") {
                let stubUserDefaultsWrapper = StubUserDefaultsWrapper()
                let notificationSwitchValueRepository = LocalNotificationSwitchValueRepository(
                    userDefaultsWrapper: stubUserDefaultsWrapper
                )
                stubUserDefaultsWrapper.loadDataBool_returnValue = true


                let actualNotificationSwitchValue
                    = notificationSwitchValueRepository.loadData()


                expect(stubUserDefaultsWrapper.loadDataBool_argument_key)
                    .to(equal("notification_switch"))
                expect(actualNotificationSwitchValue)
                    .to(equal(true))
            }
        }
    }
}
