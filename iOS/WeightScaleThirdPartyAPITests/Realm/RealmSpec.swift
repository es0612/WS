import Nimble
import Quick

import RealmSwift
/// データ構造を変更する場合は、一度シミュレータおよび実機からアプリをアンインストールする

class RealmSpec: QuickSpec {
    override func spec() {
        describe("Realmに関するテスト") {
            it("データ保存ができる"){

                let realmDB = try! Realm()

                let todaysWeight = WeightTest()
                todaysWeight.id = 1
                todaysWeight.weight = 70.0
                todaysWeight.created = Date()



                try! realmDB.write{
                    realmDB.add(todaysWeight, update: .all)
                }

                let DBItems = realmDB.objects(WeightTest.self)


                expect(DBItems.count).to(equal(1))
            }

            it("データ保存、追加できる"){

                let realmDB = try! Realm()

                let todaysWeight = WeightTest()
                todaysWeight.id = 2
                todaysWeight.weight = 65.0
                todaysWeight.created = Date()



                try! realmDB.write{
                    realmDB.add(todaysWeight, update: .all)
                }

                let DBItems = realmDB.objects(WeightTest.self)
                    .sorted(byKeyPath: "id", ascending: true)


                expect(DBItems.count).to(equal(2))
                expect(DBItems[0].weight).to(equal(70.0))
                expect(DBItems[1].weight).to(equal(65.0))
            }

            it("データ更新ができる"){

                let realmDB = try! Realm()

                let todaysWeight = WeightTest()
                todaysWeight.id = 1
                todaysWeight.weight = 60.0
                todaysWeight.created = Date()

                var DBItems = realmDB.objects(WeightTest.self).filter("id == 1")
                let updateWeight = WeightTest()

                if let unwrapedId = DBItems.first?.id  {
                    updateWeight.id = unwrapedId
                }
                updateWeight.weight = 60.0

                if let unwrapedCreated = DBItems.first?.created {
                    updateWeight.created = unwrapedCreated
                }


                try! realmDB.write{
                    realmDB.add(updateWeight, update: .all)
                }

                DBItems = realmDB.objects(WeightTest.self).filter("id = 1")


                expect(DBItems.count).to(equal(1))
                expect(DBItems.first?.weight).to(equal(60.0))
            }

            it("データ一件削除ができる"){
                let realmDB = try! Realm()

                var DBItems = realmDB.objects(WeightTest.self).filter("id = 1")

                try! realmDB.write{
                    realmDB.delete(DBItems)
                }

                DBItems = realmDB.objects(WeightTest.self)


                expect(DBItems.count).to(equal(1))
            }

            it("データ削除ができる"){
                let realmDB = try! Realm()

                try! realmDB.write{
                    realmDB.deleteAll()
                }

                let DBItems = realmDB.objects(WeightTest.self)


                expect(DBItems.count).to(equal(0))
            }
        }
    }
}
