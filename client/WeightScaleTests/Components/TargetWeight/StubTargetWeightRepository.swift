@testable import WeightScale

class StubTargetWeightRepository: TargetWeightRepository {
    private(set) var saveTargetWeight_argutment_weight = -1.0
    func saveTargetWeight(weight: Double) {
        saveTargetWeight_argutment_weight = weight
    }

    private(set) var loadTargetWeight_wasCalled = false
    var loadTargetWeight_returnValue = -1.0
    func loadTargetWeight() -> Double {
        loadTargetWeight_wasCalled = true
        return loadTargetWeight_returnValue
    }
}

