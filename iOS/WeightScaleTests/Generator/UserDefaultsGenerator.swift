import Nimble
import Quick

@testable import WeightScale

class UserDefaultsGenerator: QuickSpec {
    override func spec() {
        xdescribe(
            "UserDefaultsのテストデータを生成する(必要に応じてフォーカスして使う)"
        ) {
            let userDefaults = UserDefaults.standard

            it("目標体重を設定する") {
                userDefaults.set(55.0, forKey: "target_weight")

                let savedValue
                    = userDefaults.double(forKey: "target_weight")

                expect(savedValue).to(equal(55.0))
            }

            it("目標体重を削除する") {
                userDefaults.removeObject(forKey: "target_weight")

                let savedValue
                    = userDefaults.double(forKey: "target_weight")

                expect(savedValue).to(equal(0.0))
            }
        }
    }
}

