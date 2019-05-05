@testable import WeightScale

class StubTargetWeightRepository: TargetWeightRepository {
    private(set) var saveTargetWeight_argutment_weight = -1.0
    func saveTargetWeight(weight: Double) {
        saveTargetWeight_argutment_weight = weight
    }
}

