@testable import WeightScale

class StubRealmWrapper: RealmWrapper {
    private(set) var putData_argument_weightData: WeightData? = nil
    func putData(weightData: WeightData) {
        putData_argument_weightData = weightData
    }

    private(set) var getAllData_wasCalled = false
    var getAllData_returnValue: [WeightData] = []
    func getAllData() -> [WeightData]  {
        getAllData_wasCalled = true
        return getAllData_returnValue
    }

    private(set) var getTodayData_wasCalled = false
    var getTodayData_returnValue: WeightData? = nil
    func getTodayData() -> WeightData? {
        getTodayData_wasCalled = true
        return getTodayData_returnValue
    }

    private(set) var getMostRecentData_wasCalled = false
    var getMostRecentData_returnValue: WeightData? = nil
    func getMostRecentData() -> WeightData? {
        getMostRecentData_wasCalled = true
        return getMostRecentData_returnValue
    }
}
