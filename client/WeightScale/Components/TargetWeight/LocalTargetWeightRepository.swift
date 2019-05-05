protocol TargetWeightRepository {
    func saveTargetWeight(weight: Double)
    func loadTargetWeight() -> Double
}

class LocalTargetWeightRepository: TargetWeightRepository {
    private var userDefaultsWrapper: UserDefaultsWrapper

    init(userDefaultsWrapper: UserDefaultsWrapper) {
        self.userDefaultsWrapper = userDefaultsWrapper
    }

    func saveTargetWeight(weight: Double) {
        userDefaultsWrapper
            .saveData(key: "target_weight", value: weight)
    }

    func loadTargetWeight() -> Double {
        return userDefaultsWrapper.loadData(key: "target_weight")
    }
}
