import Foundation

protocol WeightRepository {
    func saveData(weight: Double)
    func loadData() -> [WeightData]
    func checkInputOfToday() -> Bool
    func getMostRecentWeight() -> Double?
}

class LocalWeightRepository: WeightRepository {

    private var realmWrapper: RealmWrapper

    init(realmWrapper: RealmWrapper) {
        self.realmWrapper = realmWrapper
    }

    func saveData(weight: Double) {
        let todaysWeight = WeightData()
        todaysWeight.dateString = DateManager.getToday()
        todaysWeight.weight = weight
        todaysWeight.created = Date()

        realmWrapper.putData(weightData: todaysWeight)
    }

    func loadData() -> [WeightData] {
        return realmWrapper.getAllData()
    }

    func checkInputOfToday() -> Bool {
        if let _ = realmWrapper.getTodayData() {
            return true
        }
        
        return false
    }

    func getMostRecentWeight() -> Double? {
        return nil
    }
}
