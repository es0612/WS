import RealmSwift
import Foundation

class WeightTest: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var weight: Double = 0.0
    @objc dynamic var created = Date()

    override static func primaryKey() -> String? {
        return "id"
    }
}
