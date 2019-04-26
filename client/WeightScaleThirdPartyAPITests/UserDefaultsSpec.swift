import Nimble
import Quick

class UserDefaultsSpec: QuickSpec {

    override func spec() {
        describe("UserDefaultsに関するテスト") {
            var userDefaults: UserDefaults!

            beforeEach {
                userDefaults = UserDefaults.standard
            }

            it("stringでデータを保存する"){
                userDefaults.set("test value", forKey: "test key 1")
                userDefaults.synchronize()


                let savedValue = userDefaults.string(forKey: "test key 1")
                expect(savedValue).to(equal("test value"))
            }

            it("Doubleでデータを保存する"){
                userDefaults.set(1.0, forKey: "test key 2")
                userDefaults.synchronize()


                let savedValue = userDefaults.double(forKey: "test key 2")
                expect(savedValue).to(equal(1.0))
            }

            it("保存したデータを読み込めることを確認する") {
                let savedValue = userDefaults.string(forKey: "test key 1")
                expect(savedValue).to(equal("test value"))
            }

            it("保存したデータを複数件確認する") {
                var count = 0
                for (key, _) in userDefaults.dictionaryRepresentation() {
                    if key.prefix(4) == "test" {
                        count += 1
                    }
                }


                expect(count).to(equal(2))
            }


            it("保存したデータを削除する") {
                for (key, _) in userDefaults.dictionaryRepresentation() {
                    if key.prefix(4) == "test" {
                        userDefaults.removeObject(forKey: key)
                    }
                }


                var count = 0
                for (key, _) in userDefaults.dictionaryRepresentation() {
                    if key.prefix(4) == "test" {
                        count += 1
                    }
                }

                expect(count).to(equal(0))
            }
        }
    }
}
