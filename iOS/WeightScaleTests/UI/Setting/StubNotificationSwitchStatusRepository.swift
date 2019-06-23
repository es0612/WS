@testable import WeightScale

class StubNotificationSwitchStatusRepository: NotificationSwitchStatusRepository {
    private(set) var saveData_argument_value: Bool = false
    func saveData(value: Bool) {
        saveData_argument_value = value
    }

    var loadData_returnValue = false
    func loadData() -> Bool {
        return loadData_returnValue
    }
}
