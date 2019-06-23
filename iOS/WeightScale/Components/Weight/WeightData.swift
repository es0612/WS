import RealmSwift
import Foundation

class WeightData: Object {
    @objc dynamic var dateString: String = ""
    @objc dynamic var weight: Double = 0.0
    @objc dynamic var created = Date()

    override static func primaryKey() -> String? {
        return "dateString"
    }
}
