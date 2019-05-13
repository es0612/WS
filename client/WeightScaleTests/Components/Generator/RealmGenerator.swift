import Nimble
import Quick
import RealmSwift

@testable import WeightScale

class RealmGenerator: QuickSpec {
    override func spec() {
        xdescribe(
        "Realmのテストデータを生成する(必要に応じてフォーカスして使う)"
        ) {
            var realmDB: Realm!
            
            beforeEach {
                realmDB = try! Realm()
            }

            it("データをすべて削除する") {
                var DBItems = realmDB.objects(WeightData.self)

                try! realmDB.write{
                    realmDB.delete(DBItems)
                }

                DBItems = realmDB.objects(WeightData.self)


                expect(DBItems.count).to(equal(0))
            }

            it("データを１０件生成する") {
                let dataList = [
                    ["2019/01/01", 60.0, Date()],
                    ["2019/01/02", 60.5, Date()],
                    ["2019/01/03", 60.1, Date()],
                    ["2019/01/04", 60.9, Date()],
                    ["2019/01/05", 59.2, Date()],
                    ["2019/01/06", 60.0, Date()],
                    ["2019/01/07", 60.1, Date()],
                    ["2019/01/08", 60.1, Date()],
                    ["2019/01/09", 60.7, Date()],
                    ["2019/01/20", 62.2, Date()],
                ]

                var weightDataList: [WeightData] = []
                for data in dataList {
                    let weightData = WeightData()
                    weightData.dateString = data[0] as! String
                    weightData.weight = data[1] as! Double
                    weightData.created = data[2] as! Date

                    weightDataList.append(weightData)
                }

                try! realmDB.write{
                    for weightData in weightDataList {
                        realmDB.add(weightData, update: true)
                    }
                }

                let DBItems = realmDB.objects(WeightData.self)

                expect(DBItems.count)
                    .to(equal(10))
            }
        }
    }
}
