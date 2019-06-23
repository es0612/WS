@testable import WeightScale

class StubUserDefaultsWrapper: UserDefaultsWrapper {

    private(set) var saveData_argument_key: String = ""
    private(set) var saveData_argument_value: Double = -1.0
    func saveData(key: String, value: Double) {
        saveData_argument_key = key
        saveData_argument_value = value
    }

    private(set) var loadData_argument_key: String = ""
    var loadData_returnValue = -1.0
    func loadData(key: String) -> Double {
        loadData_argument_key = key
        return loadData_returnValue
    }
}
