@testable import WeightScale

class StubWeightRepository: WeightRepository  {
    private(set) var saveData_argutment_weight = -1.0
    func saveData(weight: Double) {
        saveData_argutment_weight = weight
    }

    private(set) var loadData_wasCalled = false
    var loadData_returnValue: [WeightData] = []
    func loadData() -> [WeightData]{
        loadData_wasCalled = true
        return loadData_returnValue
    }

    private(set) var checkInputOfToday_wasCalled = false
    var checkInputOfToday_returnValue = false
    func checkInputOfToday() -> Bool {
        checkInputOfToday_wasCalled = true
        return checkInputOfToday_returnValue
    }

    var getMostRecentWeight_returnValue: Double? = -1.0
    func getMostRecentWeight() -> Double? {
        return getMostRecentWeight_returnValue
    }
}
