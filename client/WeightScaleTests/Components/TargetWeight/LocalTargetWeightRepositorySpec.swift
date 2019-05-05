import Nimble
import Quick

@testable import WeightScale

class LocalTargetWeightRepositorySpec: QuickSpec {
    override func spec() {
        describe("Local Target Weight Repository に関するテスト") {
            it("目標体重を保存する") {
                let stubUserDefaultsWrapper = StubUserDefaultsWrapper()
                let targetWeightRepository = LocalTargetWeightRepository(
                    userDefaultsWrapper: stubUserDefaultsWrapper
                )


                targetWeightRepository.saveTargetWeight(weight: 50.0)


                expect(stubUserDefaultsWrapper.saveData_argument_key)
                    .to(equal("target_weight"))
                expect(stubUserDefaultsWrapper.saveData_argument_value)
                    .to(equal(50.0))
            }

            it("保存した目標体重を取得する") {
                let stubUserDefaultsWrapper = StubUserDefaultsWrapper()
                let targetWeightRepository = LocalTargetWeightRepository(
                    userDefaultsWrapper: stubUserDefaultsWrapper
                )
                stubUserDefaultsWrapper.loadData_returnValue = 50.0


                let actualTargetWeight
                    = targetWeightRepository.loadTargetWeight()


                expect(stubUserDefaultsWrapper.loadData_argument_key)
                    .to(equal("target_weight"))
                expect(actualTargetWeight)
                    .to(equal(50.0))
            }
        }
    }
}
