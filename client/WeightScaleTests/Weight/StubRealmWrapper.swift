@testable import WeightScale

class StubRealmWrapper: RealmWrapper {
    private(set) var saveData_argument_weightData: WeightData? = nil
    func saveData(weightData: WeightData) {
        saveData_argument_weightData = weightData
    }

    private(set) var loadData_wasCalled = false
    func loadData() {
        loadData_wasCalled = true
    }
}
