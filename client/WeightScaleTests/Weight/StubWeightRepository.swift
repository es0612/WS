@testable import WeightScale

class StubWeightRepository: WeightRepository  {
    private(set) var saveData_argutment_weight = -1.0
    func saveData(weight: Double) {
        saveData_argutment_weight = weight
    }

    private(set) var loadData_wasCalled = false
    func loadData() {
        loadData_wasCalled = true
    }
}
