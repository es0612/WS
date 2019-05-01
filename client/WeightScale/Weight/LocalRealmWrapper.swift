import RealmSwift

class LocalRealmWrapper: RealmWrapper {
    func saveData(weightData: WeightData) {
        let realmDB = try! Realm()

        try! realmDB.write{
            realmDB.add(weightData, update: true)
        }
    }

    func loadData() {

    }

}
