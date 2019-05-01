@testable import WeightScale

class StubRealmWrapper: RealmWrapper {
    private(set) var saveData_argument_weightData: WeightData? = nil
    func saveData(weightData: WeightData) {
        saveData_argument_weightData = weightData
    }
}
