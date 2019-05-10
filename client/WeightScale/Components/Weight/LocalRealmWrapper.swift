import RealmSwift

protocol RealmWrapper {
    func putData(weightData: WeightData)
    func getAllData() -> [WeightData]
    func getTodayData() -> WeightData?
}

class LocalRealmWrapper: RealmWrapper {

    private let realmDB = try! Realm()

    func putData(weightData: WeightData) {
        try! realmDB.write{
            realmDB.add(weightData, update: true)
        }
    }

    func getAllData() -> [WeightData] {
        let weightDataList = realmDB.objects(WeightData.self)

        return Array(weightDataList)
    }

    func getTodayData() -> WeightData? {
        let weightDataList = realmDB
            .objects(WeightData.self)
            .filter("dateString == %@", DateManager.getToday())

        return weightDataList.first
    }

    func getMostRecentData() -> WeightData? {
        let weightDataList = realmDB
            .objects(WeightData.self)
            .sorted(byKeyPath: "created", ascending: false)

        return weightDataList.first
    }
}
