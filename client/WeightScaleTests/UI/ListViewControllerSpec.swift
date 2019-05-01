import Nimble
import Quick
import Succinct

@testable import WeightScale

class ListViewControllerSpec: QuickSpec {
    override func spec() {
        describe("List view controller に関するテスト") {
            var stubWeightRepository: StubWeightRepository!
            var listViewController: ListViewController!

            beforeEach {
                stubWeightRepository = StubWeightRepository()

                let expectedWeightData = WeightData()
                expectedWeightData.dateString = "2019/5/1"
                expectedWeightData.weight = 50.0

                stubWeightRepository.loadData_returnValue =
                    [expectedWeightData]

                listViewController = ListViewController(
                    weightRepository: stubWeightRepository
                )
            }
            
            it("タイトルが見える") {
                expect(listViewController.title)
                    .to(equal("リスト"))
            }

            it("体重データを読み込んで表示する") {
                expect(stubWeightRepository.loadData_wasCalled)
                    .to(beTrue())
                expect(listViewController.hasLabel(withExactText: "2019/5/1")).to(beTrue())
                expect(listViewController.hasLabel(withExactText: "50.0")).to(beTrue())
            }
        }
    }
}
