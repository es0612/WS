import Foundation

protocol UserDefaultsWrapper {
    func saveData(key: String, value: Double)
    func loadData(key: String) -> Double
}

class LocalUserDefaultsWrapper: UserDefaultsWrapper {
    private let userDefaults = UserDefaults.standard

    func saveData(key: String, value: Double) {
        userDefaults.set(value, forKey: key)
        userDefaults.synchronize()
    }

    func loadData(key: String) -> Double {
        return userDefaults.double(forKey: key)
    }
}
