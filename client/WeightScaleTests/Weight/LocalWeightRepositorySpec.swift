import Nimble
import Quick
import Succinct

@testable import WeightScale

class LocalWeightRepositorySpec: QuickSpec {
    override func spec() {
        describe("Realm Weight Repository に関するテスト") {
            var realmWrapper: StubRealmWrapper!
            var weightRepository: LocalWeightRepository!

            beforeEach {
                realmWrapper = StubRealmWrapper()
                weightRepository = LocalWeightRepository(
                    realmWrapper: realmWrapper
                )
            }

            it("データを保存する") {
                weightRepository.saveData(weight: 50.0)


                expect(realmWrapper.saveData_argument_weightData?.weight)
                    .to(equal(50.0))
                expect(realmWrapper.saveData_argument_weightData?.dateString)
                    .to(equal(weightRepository.getToday()))
            }

            it("データを読み込む") {
                weightRepository.loadData()


                expect(realmWrapper.loadData_wasCalled).to(beTrue())
            }
        }
    }
}
