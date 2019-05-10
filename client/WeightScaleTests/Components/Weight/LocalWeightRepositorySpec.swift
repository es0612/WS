import Nimble
import Quick

@testable import WeightScale

class LocalWeightRepositorySpec: QuickSpec {
    override func spec() {
        describe("Local Weight Repository に関するテスト") {
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


                expect(realmWrapper.putData_argument_weightData?.weight)
                    .to(equal(50.0))
                expect(realmWrapper.putData_argument_weightData?.dateString)
                    .to(equal(DateManager.getToday()))
            }

            it("データを全件読み込む") {
                let expectedWeightData = WeightData()
                expectedWeightData.weight = 50.0
                expectedWeightData.dateString
                    = DateManager.getToday()

                realmWrapper.getAllData_returnValue
                    = [expectedWeightData]


                let actualWeightDataList = weightRepository.loadData()


                expect(realmWrapper.getAllData_wasCalled)
                    .to(beTrue())
                expect(actualWeightDataList)
                    .to(equal([expectedWeightData]))
            }

            describe("今日の体重データがあるか確認する") {
                it("今日の体重データがある") {
                    let expectedWeightData = WeightData()
                    expectedWeightData.weight = 60.0
                    expectedWeightData.dateString
                        = DateManager.getToday()

                    realmWrapper.getTodayData_returnValue
                        = expectedWeightData


                    let checkResult = weightRepository.checkInputOfToday()

                    
                    expect(realmWrapper.getTodayData_wasCalled).to(beTrue())
                    expect(checkResult).to(beTrue())
                }

                it("今日の体重データがない") {
                    realmWrapper.getTodayData_returnValue = nil


                    expect(weightRepository.checkInputOfToday())
                        .to(beFalse())
                }
            }
        }
    }
}
