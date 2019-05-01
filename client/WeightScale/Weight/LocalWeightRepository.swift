import Foundation
import RealmSwift

protocol RealmWrapper {
    func saveData(weightData: WeightData)
    func loadData()
}

class LocalWeightRepository: WeightRepository {
    private var realmWrapper: RealmWrapper

    init(realmWrapper: RealmWrapper) {
        self.realmWrapper = realmWrapper
    }

    func saveData(weight: Double) {
        let todaysWeight = WeightData()
        todaysWeight.dateString = getToday()
        todaysWeight.weight = weight
        todaysWeight.created = Date()

        realmWrapper.saveData(weightData: todaysWeight)
    }

    func loadData() {
        realmWrapper.loadData()
    }
}


extension LocalWeightRepository {
    func getToday(format:String = "yyyy/MM/dd") -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: now as Date)
    }
}

class WeightData: Object {
    @objc dynamic var dateString: String = ""
    @objc dynamic var weight: Double = 0.0
    @objc dynamic var created = Date()

    override static func primaryKey() -> String? {
        return "dateString"
    }
}
