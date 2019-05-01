import Nimble
import Quick
import Succinct

@testable import WeightScale

class LocalWeightRepositorySpec: QuickSpec {
    override func spec() {
        describe("Realm Weight Repository に関するテスト") {
            it("データを保存する") {
            let realmWrapper = StubRealmWrapper()
                let weightRepository = LocalWeightRepository(realmWrapper: realmWrapper)


                weightRepository.saveData(weight: 50.0)


                expect(realmWrapper.saveData_argument_weightData?.weight).to(equal(50.0))

                    expect(realmWrapper.saveData_argument_weightData?.dateString).to(equal(weightRepository.getToday()))
            }
        }
    }
}
