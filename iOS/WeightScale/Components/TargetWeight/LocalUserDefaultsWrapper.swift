import Foundation

protocol UserDefaultsWrapper {
    func saveData(key: String, value: Double)
    func saveData(key: String, value: Bool)
    func saveData(key: String, value: Date)
    func loadData(key: String) -> Double
    func loadData(key: String) -> Bool
    func loadData(key: String) -> Date?
}

class LocalUserDefaultsWrapper: UserDefaultsWrapper {
    private let userDefaults = UserDefaults.standard

    func saveData(key: String, value: Double) {
        userDefaults.set(value, forKey: key)
        userDefaults.synchronize()
    }

    func saveData(key: String, value: Bool) {
        userDefaults.set(value, forKey: key)
        userDefaults.synchronize()
    }

    func saveData(key: String, value: Date) {
        userDefaults.set(value, forKey: key)
        userDefaults.synchronize()
    }

    func loadData(key: String) -> Double {
        return userDefaults.double(forKey: key)
    }

    func loadData(key: String) -> Bool {
        return userDefaults.bool(forKey: key)
    }

    func loadData(key: String) -> Date? {
        return userDefaults.object(forKey: key) as? Date
    }
}
