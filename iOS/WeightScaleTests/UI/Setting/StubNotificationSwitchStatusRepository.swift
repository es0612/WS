@testable import WeightScale

class StubNotificationSwitchStatusRepository: NotificationSwitchStatusRepository {
    private(set) var saveData_argument_value: Bool = false
    func saveData(value: Bool) {
        saveData_argument_value = value
    }

    private(set) var loadData_wasCalled = false
    var loadData_returnValue = false
    func loadData() -> Bool {
        loadData_wasCalled = true
        return loadData_returnValue
    }
}
