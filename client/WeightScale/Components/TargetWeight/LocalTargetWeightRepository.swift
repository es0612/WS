protocol TargetWeightRepository {
    func saveTargetWeight(weight: Double)
}

protocol UserDefaultsWrapper {
    func saveData(key: String, value: Double)
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
}
