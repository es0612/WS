import Foundation

protocol UserDefaultsWrapper {
    func saveData(key: String, value: Double)
    func saveData(key: String, value: Bool)
    func loadData(key: String) -> Double
    func loadData(key: String) -> Bool
}

class LocalUserDefaultsWrapper: UserDefaultsWrapper {
    private let userDefaults = UserDefaults.standard

    func saveData(key: String, value: Double) {
        userDefaults.set(value, forKey: key)
        userDefaults.synchronize()
    }

    func saveData(key: String, value: Bool) {

    }

    func loadData(key: String) -> Double {
        return userDefaults.double(forKey: key)
    }

    func loadData(key: String) -> Bool {
        return false
    }
}
