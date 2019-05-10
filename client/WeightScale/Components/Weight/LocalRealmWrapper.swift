import RealmSwift

protocol RealmWrapper {
    func saveData(weightData: WeightData)
    func loadData() -> [WeightData]
}

class LocalRealmWrapper: RealmWrapper {
    private let realmDB = try! Realm()

    func saveData(weightData: WeightData) {
        try! realmDB.write{
            realmDB.add(weightData, update: true)
        }
    }

    func loadData() -> [WeightData] {
        let weightDataList = realmDB.objects(WeightData.self)

        return Array(weightDataList)
    }

}
