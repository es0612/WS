@testable import WeightScale

class StubUserDefaultsWrapper: UserDefaultsWrapper {

    private(set) var saveData_argument_key: String = ""
    private(set) var saveData_argument_value: Double = -1.0
    func saveData(key: String, value: Double) {
        saveData_argument_key = key
        saveData_argument_value = value
    }

    private(set) var saveDataBool_argument_key: String = ""
    private(set) var saveDataBool_argument_value: Bool = false
    func saveData(key: String, value: Bool) {
        saveDataBool_argument_key = key
        saveDataBool_argument_value = value
    }

    private(set) var loadData_argument_key: String = ""
    var loadData_returnValue = -1.0
    func loadData(key: String) -> Double {
        loadData_argument_key = key
        return loadData_returnValue
    }

    private(set) var loadDataBool_argument_key: String = ""
    var loadDataBool_returnValue = false
    func loadData(key: String) -> Bool {
        loadDataBool_argument_key = key
        return loadDataBool_returnValue
    }
}
